//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/themes/theme_provider.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';
import 'package:wealthwatch/Data/Expense.dart'; // Import Expense data model and lists

class Statistics extends StatelessWidget {
  const Statistics({Key? key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    // Get today's date
    //DateTime now = DateTime.now();

    // Calculate weekly expenses for each category
    List<double> weeklyExpenses =
        List.filled(7, 0); // Initialize with 0 for each day
    for (int i = 0; i < 7; i++) {
      // Aggregate weekly expenses for all categories
      weeklyExpenses[i] += catFood.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);
      weeklyExpenses[i] += catTransportation.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);

      weeklyExpenses[i] += catHousing.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);

      weeklyExpenses[i] += catEntertainment.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);

      weeklyExpenses[i] += catHealth.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);

      weeklyExpenses[i] += catEducation.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);

      weeklyExpenses[i] += catMiscellaneous.expenseListItems
          .where((expense) => expense.date.weekday == i)
          .fold(0, (prev, curr) => prev + curr.expenseAmount);
    }

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
            )),
            const SizedBox(height: 250),
            Expanded(
              child: MyBarGraph(weeklySummary: weeklyExpenses),
            ),
          ],
        ),
      ),
    );
  }
}
