import 'package:flutter/material.dart';
import 'package:wealthwatch/data.dart/Expense.dart';

class expenseWindow extends StatefulWidget {
  final List<Expense> listedExpense;
  final VoidCallback? refreshCallback2;

  const expenseWindow(
      {super.key, required this.listedExpense, required this.refreshCallback2});
  @override
  State<expenseWindow> createState() => _expenseWindowState();
}

class _expenseWindowState extends State<expenseWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Expense History",
          ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Color.fromARGB(255, 58, 220, 109),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: widget.listedExpense.map((expense) {
            return ListTile(
              title: Text(expense.name),
              trailing: Text('\$${expense.expenseAmount}'),
              onLongPress: () {
                setState(() {
                  widget.listedExpense.remove(expense);
                  widget.refreshCallback2?.call();
                });
              },
            );
          }).toList(),
        ));
  }
}
