// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';

class categoryWindow extends StatefulWidget {
  final String name;
  const categoryWindow({super.key, required this.name});

  @override
  State<categoryWindow> createState() => categoryWindowState();
}

class categoryWindowState extends State<categoryWindow> {
  @override
  Widget build(BuildContext context) {
    if (widget.name == "Expense") {
      return Scaffold(
        body: Center(
          child: Column(children: [
            ListTile(
              tileColor: Colors.grey,
              title: Text('Food'),
              trailing: Text('${catFood.getTotalExpenseAmount()}'),
            ),
            ListTile(
              tileColor: Colors.grey,
              title: Text('Education'),
              trailing: Text('${catEducation.getTotalExpenseAmount()}'),
            ),
            ListTile(
              tileColor: Colors.grey,
              title: Text('Entertainment'),
              trailing: Text('${catEntertainment.getTotalExpenseAmount()}'),
            ),
            ListTile(
              tileColor: Colors.grey,
              title: Text('Health'),
              trailing: Text('${catHealth.getTotalExpenseAmount()}'),
            ),
            ListTile(
              tileColor: Colors.grey,
              title: Text('Housing'),
              trailing: Text('${catHousing.getTotalExpenseAmount()}'),
            ),
            ListTile(
              tileColor: Colors.grey,
              title: Text('Transportation'),
              trailing: Text('${catTransportation.getTotalExpenseAmount()}'),
            ),
          ]),
        ),
      );
    } else if (widget.name == 'Income') {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.greenAccent,
                title: Text("Deposit"),
                trailing: Text('${catDeposit.getTotalIncomeAmount()}'),
              ),
              ListTile(
                tileColor: Colors.greenAccent,
                title: Text("Salary"),
                trailing: Text('${catSalary.getTotalIncomeAmount()}'),
              ),
              ListTile(
                tileColor: Colors.greenAccent,
                title: Text("Rent"),
                trailing: Text('${catRent.getTotalIncomeAmount()}'),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Text("Error 404"),
    );
  }
}
