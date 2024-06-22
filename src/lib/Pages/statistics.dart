import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealthwatch/themes/theme_provider.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';
import 'package:wealthwatch/Data/Expense.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Future<List<Expense>> _futureExpenses;
  List<double> weeklyExpenses = List.filled(7, 0);
  DateTime? lastResetDate;
  final Completer<List<Expense>> _completer = Completer<List<Expense>>();

  @override
  void initState() {
    super.initState();
    _futureExpenses = _completer.future;
    _loadLastResetDate().then((_) {
      fetchExpensesFromFirebase().then((expenses) {
        _completer.complete(expenses);
      });
    });
  }

  Future<void> _loadLastResetDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastResetDateString = prefs.getString('lastResetDate');
    if (lastResetDateString != null) {
      setState(() {
        lastResetDate = DateTime.parse(lastResetDateString);
      });
    }
  }

  Future<void> _saveLastResetDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastResetDate', date.toIso8601String());
  }

  Future<List<Expense>> fetchExpensesFromFirebase() async {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Query the 'users' collection to find the document with matching UID
    QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    // Get the first document from the query result
    DocumentSnapshot userDocumentSnapshot = userQuerySnapshot.docs.first;
    String userId = userDocumentSnapshot.id;

    // Check if the current date is the start of a new week (e.g., Sunday)
    DateTime now = DateTime.now();
    if (now.weekday == DateTime.sunday &&
        (lastResetDate == null || now.difference(lastResetDate!).inDays >= 7)) {
      // Reset expenses for the new week
      setState(() {
        weeklyExpenses = List.filled(7, 0);
      });
      await _saveLastResetDate(now);
    }

    // Fetch expenses from all categories
    List<Expense> allExpenses = [];
    List<String> categories = [
      'catFood',
      'catTransportation',
      'catHousing',
      'catEntertainment',
      'catHealth',
      'catEducation',
      'catMiscellaneous'
    ];

    for (String category in categories) {
      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('ExpenseCategories')
          .doc(category)
          .collection('expenseList')
          .get();

      allExpenses.addAll(expenseSnapshot.docs.map((doc) {
        return Expense(
          name: doc['name'],
          expenseAmount: doc['amount'],
          datetime: (doc['date'] as Timestamp).toDate(),
        );
      }).toList());
    }

    return allExpenses;
  }

  void aggregateCategoryExpenses(List<Expense> expenses) {
    for (var expense in expenses) {
      int index = (expense.datetime.weekday % 7);
      weeklyExpenses[index] += expense.expenseAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: themeData.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Weekly Expense Summary',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 250),
            Expanded(
              child: FutureBuilder<List<Expense>>(
                future: _futureExpenses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No expense data available'));
                  } else {
                    // Aggregate all expenses
                    aggregateCategoryExpenses(snapshot.data!);

                    // Display the bar graph with the aggregated data
                    return MyBarGraph(weeklySummary: weeklyExpenses);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
