// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class expenseButton extends StatelessWidget {
  const expenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/addExpense');
      },
      backgroundColor: Colors.red[600],
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      heroTag: null,
      shape: const CircleBorder(),
    );
  }
}
