import 'package:flutter/material.dart';

import 'addExpense.dart';

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu(Categories);

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  Widget build(BuildContext context) {
    return DropdownMenu(
        label: const Text('Expense Name'),
        width: 180,
        dropdownMenuEntries: Categories.values
            .map((Categories) => DropdownMenuEntry(
                value: Categories,
                label: Categories.label,
                leadingIcon: Icon(Categories.icon)))
            .toList());
  }
}
