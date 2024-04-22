import 'package:flutter/material.dart';

class MyDropdownMenuExpense extends StatefulWidget {
  final controller;
  MyDropdownMenuExpense({super.key, required this.controller});

  @override
  State<MyDropdownMenuExpense> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenuExpense> {
  final categorySelection = TextEditingController();

  Widget build(BuildContext context) {
    return DropdownMenu(
      label: const Text('Expense Name'),
      controller: widget.controller,
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
  food('Food', Icons.restaurant_menu_rounded),
  transportation('Transportation', Icons.flight),
  housing('Housing', Icons.house_rounded),
  entertainment('Entertainment', Icons.tv_rounded),
  health('Health', Icons.local_hospital_rounded),
  education('Education', Icons.school_rounded),
  miscellaneous('Miscellaneous', Icons.abc_sharp);

  const expenseCategories(this.label, this.icon);
  final String label;
  final IconData icon;
}
