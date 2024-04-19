import 'package:flutter/material.dart';

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu({super.key});

  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  // List of items for the dropdown menu
  final List<Map<String, dynamic>> _items = [
    {'name': 'Food', 'icon': Icons.food_bank},
    {'name': 'Work', 'icon': Icons.work},
    {'name': 'School', 'icon': Icons.school},
    // Add more items as needed
  ];

  // Selected item
  Map<String, dynamic>? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Map<String, dynamic>>(
      value: _selectedItem,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
      },
      items: _items.map<DropdownMenuItem<Map<String, dynamic>>>((item) {
        return DropdownMenuItem<Map<String, dynamic>>(
          value: item,
          child: Row(
            children: [
              Icon(item['icon']),
              const SizedBox(width: 20), // Add some space between icon and name
              Text(item['name']),
            ],
          ),
        );
      }).toList(),
      hint: const Text('Select an item'), // Optional hint text
    );
  }
}