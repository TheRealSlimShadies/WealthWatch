import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Pages/home_page.dart';

class expenseWindow extends StatefulWidget {
  final String categoryName; //to get the category name
  final VoidCallback? refreshCallBack11;
  final VoidCallback? refresh;

  const expenseWindow(
      {super.key,
      required this.categoryName,
      required this.refreshCallBack11,
      required this.refresh});

  @override
  State<expenseWindow> createState() => _expenseWindowState();
}

class _expenseWindowState extends State<expenseWindow> {
  late Future<List<Expense>> _expenseListFuture;

  @override
  void initState() {
    super.initState();
    // this is to Fetch data as soon as the widget is initialized
    _expenseListFuture = FetchExpenseData(widget.categoryName);
  }

  Future<List<Expense>> FetchExpenseData(String categoryName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    String id = documentSnapshot.id;

    CollectionReference categoryRef = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('ExpenseCategories')
        .doc(categoryName)
        .collection('expenseList');

    QuerySnapshot querySnapshot1 = await categoryRef.get();
    List<Expense> expenses = [];
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot1.docs) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data != null) {
        Expense expense = Expense(
          id: documentSnapshot
              .id, // storing the document ID. needed for deletion later.
          name: data['name'] ?? '',
          expenseAmount: data['amount'] ?? 0,
          datetime: (data['date'] as Timestamp).toDate(),
        );
        expenses.add(expense);
      }

      expenses.sort(((a, b) => b.datetime.compareTo(a.datetime)));
    }
    return expenses;
  }

  Future<void> deleteExpense(String categoryName, String expenseId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    String userId = documentSnapshot.id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('ExpenseCategories')
        .doc(categoryName)
        .collection('expenseList')
        .doc(expenseId)
        .delete();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.all(16),
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.amber,
        ),
        child: Column(
          children: [
            Text(message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                )),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense History"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Color.fromARGB(255, 58, 220, 109),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            widget.refreshCallBack11!();
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _expenseListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<Expense> expenses = snapshot.data!;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                Expense expense = expenses[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1),
                    ),
                    child: ListTile(
                      title: Text(
                        expense.name,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        '\$${expense.expenseAmount}',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        '${expense.datetime.year} / ${expense.datetime.month} / ${expense.datetime.day} ${expense.datetime.hour}:${expense.datetime.minute}',
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      onLongPress: () async {
                        await deleteExpense(widget.categoryName, expense.id);
                        setState(() {
                          expenses.removeAt(index);
                        });

                        _showSnackBar(" \$${expense.expenseAmount} removed");
                        //_showSnackBar("Expense of \$${expenseNumber} deducted");
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
