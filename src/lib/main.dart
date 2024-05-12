import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/Buttons/expenseButton.dart';
import 'package:wealthwatch/Buttons/incomeButton.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';
import 'package:wealthwatch/Pages/addIncome.dart';
import 'package:wealthwatch/Pages/calendar.dart';
import 'package:wealthwatch/Pages/cofund.dart';
import 'package:wealthwatch/Pages/home_page.dart';
import 'package:wealthwatch/Pages/settings.dart';
import 'package:wealthwatch/Pages/statistics.dart';
import 'package:wealthwatch/Pages/addExpense.dart';
import 'package:wealthwatch/themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(
        title: '',
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/homepage': (context) => const Home(
              title: '',
            ),
        '/statistic': (context) => const Statistics(),
        '/settings': (context) => const Settings(),
        '/cofund': (context) => const coFund(),
        '/calendar': (context) => const Calendar(),
        '/expbutton': (context) => const expenseButton(),
        '/incbutton': (context) => const incomeButton(),
        '/addExpense': (context) => const addExpense(),
        '/addIncome': (context) => const addIncome(),
        '/BarChart': (context) => const MyBarGraph(
              weeklySummary: [],
            ),
      },
    );
  }
}
