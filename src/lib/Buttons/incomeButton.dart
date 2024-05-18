// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:wealthwatch/Pages/addIncome.dart';

class incomeButton extends StatelessWidget {
  final VoidCallback? refreshCallback4;
  const incomeButton({
    super.key,
    required this.refreshCallback4,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 60,
        minWidth: 120,
        color: Colors.green[600],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addIncome(
                refreshCallBack5:
                    refreshCallback4, // Pass the refresh function as a callback
              ),
            ),
          );
          refreshCallback4?.call();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }
}
