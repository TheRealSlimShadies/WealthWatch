// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'dropDownMenuIncome.dart';

class addIncome extends StatefulWidget {
  final VoidCallback? refreshCallBack5;
  const addIncome({super.key, required this.refreshCallBack5});

  @override
  State<addIncome> createState() => _addIncomeState();
}

class _addIncomeState extends State<addIncome> {
  final categorySelection1 = TextEditingController();


  Future<void> addIncomesToCategory(String categoryName, Income income) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('users').where('auth id', isEqualTo: uid).get();

  DocumentSnapshot documentSnapshot= querySnapshot.docs.first;

  String id= documentSnapshot.id;

  CollectionReference categoryRef = FirebaseFirestore.instance.collection('users').doc(id).collection('IncomeCategories').doc(categoryName).collection('incomeList');
  
    await categoryRef.add({
      'amount': income.incomeAmount,
    });


}


  @override
  Widget build(BuildContext context) {
    final TextEditingController incomeNumberController =
        TextEditingController();
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
                child: MyDropdownMenuIncome(
                  controller: categorySelection1,
                ),
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
                      labelText: "Enter Income Number",
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
            onPressed: () {
              String incomeNumbercontroller = incomeNumberController.text;
              int incomeNumber = int.tryParse(incomeNumbercontroller) ?? 0;

              Income newIncome = Income(
              incomeAmount: incomeNumber,
              ); 

              switch (categorySelection1.text) {
                case 'Rent':
                  catRent.addIncomeToList(newIncome);
                  addIncomesToCategory('catRent', newIncome);
                  break;
                case 'Deposit':
                  catDeposit.addIncomeToList(Income(incomeAmount: incomeNumber));
                  addIncomesToCategory('catDeposit', newIncome);
                  break;
                case 'Salary':
                  catSalary.addIncomeToList(Income(incomeAmount: incomeNumber));
                  addIncomesToCategory('catSalary', newIncome);
                  break;
              }
              widget.refreshCallBack5!();
              Navigator.pop(context);
            },
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
