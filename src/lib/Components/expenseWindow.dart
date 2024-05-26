import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';

class expenseWindow extends StatefulWidget {
  final List<Expense> listedExpense;

  const expenseWindow({
    super.key,
    required this.listedExpense,
  });
  @override
  State<expenseWindow> createState() => _expenseWindowState();
}

class _expenseWindowState extends State<expenseWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense History",
          ),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: const Color.fromARGB(255, 58, 220, 109),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.popAndPushNamed(context, '/homepage');
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
                });
              },
            );
          }).toList(),
        ));
  }
}
