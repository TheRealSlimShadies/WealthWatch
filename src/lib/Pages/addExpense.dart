// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'dropDownMenuExpense.dart';
import 'dropDownMenuIncome.dart';


class addExpense extends StatefulWidget {
  final VoidCallback? refreshCallback;

  addExpense({
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

Future<void> addExpensesToCategory(String categoryName, Expense expense) async {

   // Get the current user's UID
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // Query the 'users' collection to find the document with matching UID
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('auth id', isEqualTo: uid).get();

    // Get the first document from the query result
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

    String id= documentSnapshot.id;



  CollectionReference categoryRef = FirebaseFirestore.instance.collection('users').doc(id).collection('ExpenseCategories').doc(categoryName).collection('expenseList');
  
    await categoryRef.add({
      'name': expense.name,
      'amount': expense.expenseAmount,
      'date': expense.datetime,
    });
  
}





  @override
  Widget build(BuildContext context) {
    final categorySelection = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add an Expense",
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.red[500],
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: expenseLabelController,
              decoration: InputDecoration(
                  hintText: "Enter Expense Name",
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 15, bottom: 20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter the name of the item for better history log.";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: MyDropdownMenuExpense(
                    controller: categorySelection,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: expenseNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Expense Number",
                      labelStyle: TextStyle(fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
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
          FloatingActionButton(
            onPressed: () {
              String expenseLabel = expenseLabelController.text;
              String expensenumbercontroller = expenseNumberController.text;
              int expenseNumber = int.tryParse(expensenumbercontroller) ?? 0;

              Expense newExpense = Expense(
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
              widget.refreshCallback!();
              Navigator.pop(context);
          },
            backgroundColor: Colors.red,
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
