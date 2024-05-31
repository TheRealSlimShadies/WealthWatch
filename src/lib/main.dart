import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/Authentication/auth.dart';
import 'package:wealthwatch/Authentication/forgotPassword.dart';
import 'package:wealthwatch/Authentication/login.dart';
import 'package:wealthwatch/Authentication/register.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        builder: (context, child) {
          return const MyApp();
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/homepage': (context) => Home(),
        '/statistic': (context) => Statistics(),
        '/settings': (context) => Setting(),
        '/cofund': (context) => coFund(),
        '/calendar': (context) => Calendar(),
        '/expbutton': (context) => expenseButton(),
        '/addExpense': (context) => addExpense(),
        '/forgotPassword': (context) => forgotPassword(),
        '/BarChart': (context) => MyBarGraph(weeklySummary: []),

        '/login': (context) => Login(onTap: () {
          // navigate to registration screen. this is used only for delete account method where i need to route out of the app to login page
          Navigator.pushNamed(context, '/register');
        }),
        '/register': (context) => Register(onTap: () {
          Navigator.pushNamed(context, '/login');
        }),


        //'/login': (context) => Login(),
        //'/register':(context) => Register(),
      },
    );
  }
}
