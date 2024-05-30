import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';

class expenseWindow extends StatefulWidget {
  final String categoryName; //to get the category name
  final VoidCallback? refreshCallBack11;

  const expenseWindow({
    super.key,
    required this.categoryName,
    required this.refreshCallBack11,
  });

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

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('auth id', isEqualTo: uid).get();

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
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>;
      if (data != null) {
        Expense expense = Expense(
          name: data['name'] ?? '',
          expenseAmount: data['amount']?? 0,
          datetime: (data['date'] as Timestamp).toDate(),
        );
        expenses.add(expense);
      }
    }
    return expenses;
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
          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) 
          {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          else if (snapshot.hasData) 
          {
            List<Expense> expenses = snapshot.data!;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                Expense expense = expenses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      onLongPress: () {
                        setState(() {
                          expenses.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } 
          else 
          {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
