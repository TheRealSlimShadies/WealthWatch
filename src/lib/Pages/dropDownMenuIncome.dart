import 'package:flutter/material.dart';

class MyDropdownMenuIncome extends StatefulWidget {
  final controller;
  const MyDropdownMenuIncome({super.key, required this.controller});

  @override
  State<MyDropdownMenuIncome> createState() => _MyDropdownMenuState();
}

final controller = TextEditingController();

class _MyDropdownMenuState extends State<MyDropdownMenuIncome> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        label: const Text('Income Name'),
        width: 180,
        controller: widget.controller,
        dropdownMenuEntries: incomeCategories.values
            .map((incomeCategories) => DropdownMenuEntry(
                value: incomeCategories,
                label: incomeCategories.label,
                leadingIcon: Icon(incomeCategories.icon)))
            .toList());
  }
}

enum incomeCategories {
  deposit('Deposit', Icons.shopping_bag_rounded),
  rent('Rent', Icons.house),
  salary('Salary', Icons.account_balance_rounded);

  const incomeCategories(this.label, this.icon);
  final String label;
  final IconData icon;
}
