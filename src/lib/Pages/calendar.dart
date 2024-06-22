import 'dart:math';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wealthwatch/Data/Expense.dart'; // Import your Expense model
import 'package:wealthwatch/themes/theme_provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? startSelectedDay;
  DateTime? endSelectedDay;
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    startSelectedDay = null;
    endSelectedDay = null;
  }

  Future<void> fetchExpenses(DateTime? start, DateTime? end) async {
    if (start == null) return;

    //for singleday selection, set end to the same as start
    DateTime adjustedEnd = end ?? start;

    //ensure the start date begins at 00:00:00
    DateTime adjustedStart =
        DateTime(start.year, start.month, start.day, 0, 0, 0);

    //ensure the end date ends at 23:59:59
    adjustedEnd = DateTime(
        adjustedEnd.year, adjustedEnd.month, adjustedEnd.day, 23, 59, 59);

    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    String userId = documentSnapshot.id;

    QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('ExpenseCategories')
        .get();

    List<Expense> expenses = [];
    for (var categoryDoc in expenseSnapshot.docs) {
      CollectionReference expenseListRef =
          categoryDoc.reference.collection('expenseList');
      QuerySnapshot expenseListSnapshot = await expenseListRef
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromDate(adjustedStart))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(adjustedEnd))
          .get();

      for (var doc in expenseListSnapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          expenses.add(Expense(
            id: doc.id,
            name: data['name'] ?? '',
            expenseAmount: data['amount'] ?? 0,
            datetime: (data['date'] as Timestamp).toDate(),
          ));
        }
      }
    }
    //sort the expenses by date
    expenses.sort(((a, b) => b.datetime.compareTo(a.datetime)));

    setState(() {
      _expenses = expenses;
    });
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        title: Text('Calendar'),
        centerTitle: true,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        //Container(
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(1875, 01, 01),
          lastDay: DateTime.utc(3040, 01, 31),
          selectedDayPredicate: (day) => isSameDay(startSelectedDay, day),
          rangeStartDay: startSelectedDay,
          rangeEndDay: endSelectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              startSelectedDay = selectedDay;
              endSelectedDay = null;
            });
          },
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          // availableCalendarFormats: const {
          //  CalendarFormat.month: 'Month',
          // },
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              startSelectedDay = start;
              endSelectedDay = end;
            });
          },
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
        ),
        //),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await fetchExpenses(startSelectedDay, endSelectedDay);
          },
          child: Text(
            'Fetch Expenses',
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              startSelectedDay = null;
              endSelectedDay = null;
              _expenses = [];
            });
          },
          child: Text(
            'Clear Selection',
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _expenses.isNotEmpty
              ? Scrollbar(
                  thickness: 10,
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final expense = _expenses[index];
                      final isSameDayAsPrevious = index > 0 &&
                          _expenses[index - 1].datetime.day ==
                              expense.datetime.day &&
                          _expenses[index - 1].datetime.month ==
                              expense.datetime.month &&
                          _expenses[index - 1].datetime.year ==
                              expense.datetime.year;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isSameDayAsPrevious)
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  //child: Text(
                                  //'${expense.datetime.day} / ${expense.datetime.month} / ${expense.datetime.year}',
                                  //style: TextStyle(
                                  //fontSize: 18,
                                  //fontWeight: FontWeight.bold,
                                  //),
                                  //),
                                ),
                                Container(
                                  height: 4.0,
                                  color: getRandomColor(),
                                ),
                              ],
                            ),
                          ListTile(
                            title: Text(expense.name),
                            subtitle: Text(
                                '${expense.datetime.day}/ ${expense.datetime.month} / ${expense.datetime.year}'),
                            trailing: Text('\$${expense.expenseAmount}'),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No expenses for the selected date range')),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Calendar(),
  ));
}
