// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:wealthwatch/Pages/addExpense.dart';

class expenseButton extends StatelessWidget {
  final VoidCallback? refreshCallback1;
  const expenseButton({super.key, this.refreshCallback1});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.red,
        height: 60,
        minWidth: 120,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addExpense(
                refreshCallback:
                    refreshCallback1, // Pass the refresh function as a callback
              ),
            ),
          );
          refreshCallback1?.call();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }
}
