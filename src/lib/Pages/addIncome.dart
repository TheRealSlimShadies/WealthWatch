// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'dropDownMenuIncome.dart';

class addIncome extends StatefulWidget {
  addIncome({super.key});

  @override
  State<addIncome> createState() => _addIncomeState();
}

class _addIncomeState extends State<addIncome> {
  List<String> categories = ['Food', 'Transportation'];

  @override
  Widget build(BuildContext context) {

    final TextEditingController incomeAmountController = TextEditingController();
    final TextEditingController incomeNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add an Income",
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Color.fromARGB(255, 58, 220, 109),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: MyDropdownMenuIncome(),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: incomeNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Expense Number",
                      labelStyle: TextStyle(fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(left: 20, top: 15, bottom: 20),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment
            .end, // Align the FloatingActionButton to the right
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color.fromARGB(255, 78, 246, 80),
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
