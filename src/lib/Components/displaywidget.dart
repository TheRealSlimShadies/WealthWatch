import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      height: 50,
      width: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.cyan),
      child: Center(
        child: Text(
          'Total $name: $amount',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
