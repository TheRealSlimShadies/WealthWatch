import 'package:flutter/material.dart';
import 'package:wealthwatch/Authentication/auth.dart';
import 'package:wealthwatch/Authentication/login.dart';
import 'package:wealthwatch/Buttons/expenseButton.dart';
import 'package:wealthwatch/Buttons/incomeButton.dart';
import 'package:wealthwatch/Pages/addIncome.dart';
import 'package:wealthwatch/Pages/calendar.dart';
import 'package:wealthwatch/Pages/cofund.dart';
import 'package:wealthwatch/Pages/home_page.dart';
import 'package:wealthwatch/Pages/settings.dart';
import 'package:wealthwatch/Pages/statistics.dart';
import 'package:wealthwatch/Pages/addExpense.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/homepage': (context) => Home(),
        '/statistic': (context) => Statistics(),
        '/settings': (context) => Settings(),
        '/cofund': (context) => coFund(),
        '/calendar': (context) => Calendar(),
        '/expbutton': (context) => expenseButton(),
        '/incbutton': (context) => incomeButton(),
        '/addExpense': (context) => addExpense(),
        '/addIncome': (context) => addIncome(),
        //'/login': (context) => Login(),
        //'/register':(context) => Register(),
      },
    );
  }
}
