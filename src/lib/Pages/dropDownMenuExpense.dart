import 'package:flutter/material.dart';

class MyDropdownMenuExpense extends StatefulWidget {
  const MyDropdownMenuExpense({super.key});
  String somethingsomething(String x) {
    return x;
  }

  @override
  State<MyDropdownMenuExpense> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenuExpense> {
  final categorySelection = TextEditingController();

  Widget build(BuildContext context) {
    return DropdownMenu(
      label: const Text('Expense Name'),
      controller: categorySelection,
      width: 180,
      dropdownMenuEntries: expenseCategories.values
          .map((expenseCategories) => DropdownMenuEntry(
              value: expenseCategories,
              label: expenseCategories.label,
              leadingIcon: Icon(expenseCategories.icon)))
          .toList(),
    );
  }
}

enum expenseCategories {
  food('Food', Icons.food_bank),
  transportation('Transportation', Icons.flight);

  const expenseCategories(this.label, this.icon);
  final String label;
  final IconData icon;
}
