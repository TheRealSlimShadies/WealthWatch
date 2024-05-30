import 'package:flutter/material.dart';

class amountDisplayer extends StatelessWidget {
  final double amount1;
  const amountDisplayer({super.key, required this.amount1});

  @override
  Widget build(BuildContext context) {
    if (amount1 > 0) {
      return Container(
        child: Text(
          '$amount1',
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.green[800]),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container(
        child: Text(
          '$amount1',
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.red[800]),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
