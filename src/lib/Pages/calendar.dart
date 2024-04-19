import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Calendar"),
        centerTitle: true,
      ),
      body: content(),
    );
  }

  Widget content() {
    DateTime today = DateTime.now();
    return Column(
      children: [
        //const Text("123"),
        Container(
          child: TableCalendar(
            focusedDay: today,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
          ),
        ),
      ],
    );
  }
}
