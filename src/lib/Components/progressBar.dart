import 'package:flutter/material.dart';

class progressBar extends StatefulWidget {
  final totalExpense;
  final totalIncome;
  const progressBar({
    super.key,
    required this.totalExpense,
    required this.totalIncome,
  });

  @override
  State<progressBar> createState() => _progressBarState();
}

class _progressBarState extends State<progressBar> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: widget.totalExpense / (widget.totalIncome + 0.0000000000001),
      color: Colors.red,
      minHeight: 15,
      borderRadius: BorderRadius.circular(5),
      backgroundColor: Colors.green,
    );
  }
}
