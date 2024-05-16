import 'package:flutter/material.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';

class displaywidget extends StatelessWidget {
  final int amount;
  final String name;
  const displaywidget({
    super.key,
    required this.amount,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
