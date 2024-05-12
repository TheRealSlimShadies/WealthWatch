import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime? _startSelectedDay;
  late DateTime? _endSelectedDay;

  @override
  void initState() {
    super.initState();
    _startSelectedDay = null;
    _endSelectedDay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(1875, 01, 01),
            lastDay: DateTime.utc(3040, 01, 31),
            rangeStartDay: _startSelectedDay,
            rangeEndDay: _endSelectedDay,
            rangeSelectionMode: RangeSelectionMode.enforced,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _startSelectedDay = start;
                _endSelectedDay = end;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _startSelectedDay = null;
              _endSelectedDay = null;
            });
          },
          child: const Text('Clear Selection'),
        ),
        const SizedBox(height: 20),

        //Text
        //"Selected range: ${_startSelectedDay.toString().split(" ")[0]} - ${_endSelectedDay.toString().split(" ")[0]}",
        //style: const TextStyle(fontSize: 16),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Calendar(),
  ));
}
