import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/themes/theme_provider.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';
import 'package:wealthwatch/Data/Expense.dart'; // Import Expense data model and lists

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    // Calculate weekly expenses for each category
    List<double> weeklyExpenses =
        List.filled(7, 0); // Initialize with 0 for each day

    // Define a function to aggregate expenses for a category
    void aggregateCategoryExpenses(List<Expense> expenses) {
      for (var expense in expenses) {
        // Adjust the index for Sunday to be 0
        int index = (expense.datetime.weekday % 7);
        weeklyExpenses[index] += expense.expenseAmount;
      }
    }

    // Aggregate weekly expenses for all categories
    aggregateCategoryExpenses(catFood.expenseListItems);
    aggregateCategoryExpenses(catTransportation.expenseListItems);
    aggregateCategoryExpenses(catHousing.expenseListItems);
    aggregateCategoryExpenses(catEntertainment.expenseListItems);
    aggregateCategoryExpenses(catHealth.expenseListItems);
    aggregateCategoryExpenses(catEducation.expenseListItems);
    aggregateCategoryExpenses(catMiscellaneous.expenseListItems);

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
