import 'package:flutter/material.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Components/categoryWindow.dart';

class displaywidget extends StatelessWidget {
  final double amount;
  final String name;
  final VoidCallback? refreshCallBack14;
  const displaywidget(
      {super.key,
      required this.amount,
      required this.name,
      required this.refreshCallBack14});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => categoryWindow(
              name: name,
              refreshCallBack13: refreshCallBack14,
            ),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          height: 50,
          width: 170,
          child: Center(
            child: Text(
              'Total $name: $amount',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Color(0xAA4CA9DF), Color(0xAA292E91)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ))),
    );
  }
}
