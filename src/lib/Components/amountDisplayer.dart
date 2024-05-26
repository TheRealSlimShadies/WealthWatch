import 'package:flutter/material.dart';

class amountDisplayer extends StatelessWidget {
  final int amount1;
  const amountDisplayer({super.key, required this.amount1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Remaining Balance: $amount1',
        style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}
