// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wealthwatch/data.dart/Expense.dart';
import 'dropDownMenuExpense.dart';
import 'dropDownMenuIncome.dart';

class addExpense extends StatefulWidget {
   
   final VoidCallback? refreshCallback;

  addExpense({
    super.key, this.refreshCallback,
  });

  @override
  State<addExpense> createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {
  final TextEditingController expenseLabelController = TextEditingController();

  final TextEditingController expenseNumberController = TextEditingController();

  final categorySelection = TextEditingController();

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: expenseLabelController,
            decoration: InputDecoration(
                hintText: "Enter Expense Name",
                contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Valid Name";
              } 
              else {
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Align the FloatingActionButton to the right
        children: [
          FloatingActionButton(
            onPressed: () {
              String expenseLabel = expenseLabelController.text;
              String expensenumbercontroller = expenseNumberController.text;
              int expenseNumber = int.tryParse(expensenumbercontroller) ?? 0;
              switch (categorySelection.text) {
                case 'Food':
                  catFood.addExpenseToList(Expense(
                      name: expenseLabel, expenseAmount: expenseNumber));
                case 'Transportation':
                  catTransportation.addExpenseToList(Expense(
                      name: expenseLabel, expenseAmount: expenseNumber));
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
