// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'dropDownMenuExpense.dart';
//import 'dropDownMenuIncome.dart';

class addExpense extends StatefulWidget {
  final VoidCallback? refreshCallback;

  const addExpense({
    super.key,
    this.refreshCallback,
  });

  @override
  State<addExpense> createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {
  final TextEditingController expenseLabelController = TextEditingController();

  final TextEditingController expenseNumberController = TextEditingController();

  final categorySelection = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> addExpensesToCategory(
      String categoryName, Expense expense) async {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Query the 'users' collection to find the document with matching UID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    // Get the first document from the query result
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      String id = documentSnapshot.id;

      CollectionReference categoryRef = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('ExpenseCategories')
          .doc(categoryName)
          .collection('expenseList');

      // format the datetime before adding to Firestore

      //String formattedDate = DateFormat('dd-MM-yyyy').format(expense.datetime);

      await categoryRef.add({
        'name': expense.name,
        'amount': expense.expenseAmount,
        'date': expense.datetime,
        //formattedDate,
        //DateFormat('dd-MM-yyyy').format(expense.datetime),
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.red,
        ),
        child: Column(
          children: [
            Text(message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 19,
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
    //final categorySelection = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add an Expense",
        ),
        toolbarHeight: 60,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xF0500b28), Color(0xF0e21c34)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                maxLength: 20,
                controller: expenseLabelController,
                decoration: InputDecoration(
                    hintText: "Enter Expense Name",
                    contentPadding:
                        EdgeInsets.only(left: 20, top: 15, bottom: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the name of the item for better history log.";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: MyDropdownMenuExpense(
                    controller: categorySelection,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 180,
                  child: TextFormField(
                    controller: expenseNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Expense Number",
                      labelStyle: TextStyle(fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment
            .end, // Align the FloatingActionButton to the right
        children: [
          MaterialButton(
            onPressed: () {
              String expenseLabel = expenseLabelController.text;
              String expensenumbercontroller = expenseNumberController.text;
              int expenseNumber = int.tryParse(expensenumbercontroller) ?? 0;

              Expense newExpense = Expense(
                id: '', //temporary id
                name: expenseLabel,
                expenseAmount: expenseNumber,
                datetime: DateTime.now(),
              );

              switch (categorySelection.text) {
                case 'Food':
                  catFood.addExpenseToList(newExpense);
                  addExpensesToCategory('catFood', newExpense);
                  break;
                case 'Transportation':
                  catTransportation.addExpenseToList(newExpense);
                  addExpensesToCategory('catTransportation', newExpense);
                  break;
                case 'Health':
                  catHealth.addExpenseToList(newExpense);
                  addExpensesToCategory('catHealth', newExpense);
                  break;
                case 'Entertainment':
                  catEntertainment.addExpenseToList(newExpense);
                  addExpensesToCategory('catEntertainment', newExpense);
                  break;
                case 'Miscellaneous':
                  catMiscellaneous.addExpenseToList(newExpense);
                  addExpensesToCategory('catMiscellaneous', newExpense);
                  break;
                case 'Education':
                  catEducation.addExpenseToList(newExpense);
                  addExpensesToCategory('catEducation', newExpense);
                  break;
                case 'Housing':
                  catHousing.addExpenseToList(newExpense);
                  addExpensesToCategory('catHousing', newExpense);
                  break;
              }

              _showSnackBar(" \$${expenseNumber} deducted ");

              if (widget.refreshCallback != null) {
                widget.refreshCallback!();
              }
              Navigator.pop(context, {
                'amount': expenseNumber,
                'category': categorySelection.text,
              });
            },
            color: Colors.red,
            minWidth: 90,
            height: 70,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
