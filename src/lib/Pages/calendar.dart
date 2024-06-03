import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wealthwatch/Data/Expense.dart'; // Import your Expense model

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
    if (start == null || end == null) return;

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
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
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
            rangeStartDay: startSelectedDay,
            rangeEndDay: endSelectedDay,
            rangeSelectionMode: RangeSelectionMode.enforced,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                startSelectedDay = start;
                endSelectedDay = end;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await fetchExpenses(startSelectedDay, endSelectedDay);
          },
          child: const Text('Fetch Expenses'),
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
          child: const Text('Clear Selection'),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _expenses.isNotEmpty
              ? ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    final expense = _expenses[index];
                    return ListTile(
                      title: Text(expense.name),
                      subtitle: Text(
                          '${expense.datetime.day} / ${expense.datetime.month} / ${expense.datetime.year}'),
                      trailing: Text('\$${expense.expenseAmount}'),
                    );
                  },
                )
              : Center(child: Text('No expenses for the selected date range')),
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
