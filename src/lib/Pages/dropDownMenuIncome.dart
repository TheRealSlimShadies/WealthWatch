import 'package:flutter/material.dart';

class MyDropdownMenuIncome extends StatefulWidget {
  const MyDropdownMenuIncome();

  @override
  State<MyDropdownMenuIncome> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenuIncome> {
  Widget build(BuildContext context) {
    return DropdownMenu(
        label: const Text('Expense Name'),
        width: 180,
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
