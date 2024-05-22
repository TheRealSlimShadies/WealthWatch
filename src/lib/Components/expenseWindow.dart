import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';

class expenseWindow extends StatefulWidget {
  final List<Expense> listedExpense;
  final VoidCallback? refreshCallBack11;
  const expenseWindow(
      {super.key,
      required this.listedExpense,
      required this.refreshCallBack11});
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
              widget.refreshCallBack11!();
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: widget.listedExpense.map((expense) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1)),
                child: ListTile(
                  title: Text(
                    expense.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    '\$${expense.expenseAmount}',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                      '${expense.datetime.year} / ${expense.datetime.month} / ${expense.datetime.day}    ${expense.datetime.hour}: ${expense.datetime.minute}'),
                  titleAlignment: ListTileTitleAlignment.center,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  onLongPress: () {
                    setState(() {
                      widget.listedExpense.remove(expense);
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ));
  }
}
