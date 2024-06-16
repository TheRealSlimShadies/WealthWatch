// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Buttons/expenseButton.dart';
import 'package:wealthwatch/Buttons/incomeButton.dart';
import 'package:wealthwatch/Components/amountDisplayer.dart';
import 'package:wealthwatch/Components/displaywidget.dart';
import 'package:wealthwatch/Components/progressBar.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Graphs/pieChart.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  // method to fetch the first name and return it
  Future<String> getFirstName() async {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Query the 'users' collection to find the document with matching UID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document from the query result
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Get the data from the document
      Map<String, dynamic> userData =
          documentSnapshot.data() as Map<String, dynamic>;

      // Extract the first name
      String firstName = userData['first name'] ?? '';

      // Return the first name
      return firstName;
    } else {
      // No matching document found
      return '';
    }
  }

  // method to sign user out
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void signUserOutPopUpBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Logging Out..."),
              content: Text("Do you want to log out?"),
              actions: [
                TextButton(
                    onPressed: () {
                      print("SIGNING OUT...............");
                      signUserOut();
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
              ]);
        });
  }

  // method to get total expense amount
  Future<double> getTotalExpenseAmount() async {
    double totalExpenseAmount = 0.0;

    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Query the 'users' collection to find the document with matching UID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document from the query result
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      String userId = documentSnapshot.id;

      List<String> expenseCategories = [
        'catEducation',
        'catEntertainment',
        'catFood',
        'catHealth',
        'catHousing',
        'catMiscellaneous',
        'catTransportation'
      ];

      for (String category in expenseCategories) {
        CollectionReference expenseListRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('ExpenseCategories')
            .doc(category)
            .collection('expenseList');

        QuerySnapshot expenseListSnapshot = await expenseListRef.get();

        for (QueryDocumentSnapshot expense in expenseListSnapshot.docs) {
          Map<String, dynamic> expenseData =
              expense.data() as Map<String, dynamic>;
          double amount = (expenseData['amount'] ?? 0.0).toDouble();
          totalExpenseAmount += amount;
        }
      }
    }

    return totalExpenseAmount;
  }

  // method to get total income amount
  Future<double> getTotalIncomeAmount() async {
    double totalIncomeAmount = 0.0;

    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Query the 'users' collection to find the document with matching UID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document from the query result
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      String userId = documentSnapshot.id;

      List<String> incomeCategories = ['catRent', 'catSalary', 'catDeposit'];

      for (String category in incomeCategories) {
        CollectionReference incomeListRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('IncomeCategories')
            .doc(category)
            .collection('incomeList');

        QuerySnapshot incomeListSnapshot = await incomeListRef.get();

        for (QueryDocumentSnapshot income in incomeListSnapshot.docs) {
          Map<String, dynamic> incomeData =
              income.data() as Map<String, dynamic>;
          double amount = (incomeData['amount'] ?? 0.0).toDouble();
          totalIncomeAmount += amount;
        }
      }
    }

    return totalIncomeAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        title: Text(
          "My Wallet",
          style: TextStyle(
              fontFamily: 'MVBoli',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 27, 181, 198), Color.fromARGB(255, 41, 62, 145)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
        ),
        actions: [
          IconButton(
              onPressed: signUserOutPopUpBox,
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      drawer: Drawer(
        //backgroundColor: Color.fromARGB(197, 255, 255, 255),
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(0.8),
        child: Center(
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 70,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              FutureBuilder<String>(
                future: getFirstName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("error: ${snapshot.error}");
                  } else {
                    String username = snapshot.data ?? '';
                    return Text(
                      "Hi, $username",
                      style: TextStyle(fontSize: 20, fontFamily: "Arial"),
                    );
                  }
                },
              ),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet,
                      size: 30, color: Theme.of(context).iconTheme.color),
                  title: Text(
                    'Statistics',
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/statistic');
                  }),
              // ListTile(
              //     contentPadding: EdgeInsets.only(left: 40, top: 70),
              //     leading: Icon(
              //       Icons.account_balance_wallet,
              //       size: 30,
              //       color: Theme.of(context).iconTheme.color,
              //     ),
              //     title: Text(
              //       'Co-Fund',
              //       style: TextStyle(
              //           fontSize: 17,
              //           color: Theme.of(context).textTheme.bodyLarge!.color),
              //     ),
              //     onTap: () {
              //       Navigator.pop(context);
              //       Navigator.pushNamed(context, '/cofund');
              //     }),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet,
                      size: 30, color: Theme.of(context).iconTheme.color),
                  title: Text(
                    'Calendar',
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendar');
                  }),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet,
                      size: 30, color: Theme.of(context).iconTheme.color),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  }),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<double>(
                future: getTotalExpenseAmount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    double totalExpense = snapshot.data ?? 0.0;
                    return displaywidget(
                      amount: totalExpense,
                      name: 'Expense',
                      refreshCallBack14: refresh,
                    );
                  }
                },
              ),
              FutureBuilder<double>(
                future: getTotalIncomeAmount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    double totalIncome = snapshot.data ?? 0.0;
                    return displaywidget(
                      amount: totalIncome,
                      name: 'Income',
                      refreshCallBack14: refresh,
                    );
                  }
                },
              ),
            ],
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(),
            child: pieChart(
              refreshCallBack10: refresh,
            ),
          )),
          Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder<double>(
                future: getTotalExpenseAmount(),
                builder: (context, expenseSnapshot) {
                  if (expenseSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (expenseSnapshot.hasError) {
                    return Text("Error: ${expenseSnapshot.error}");
                  } else {
                    double totalExpense = expenseSnapshot.data ?? 0.0;
                    return FutureBuilder<double>(
                      future: getTotalIncomeAmount(),
                      builder: (context, incomeSnapshot) {
                        if (incomeSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (incomeSnapshot.hasError) {
                          return Text("Error: ${incomeSnapshot.error}");
                        } else {
                          double totalIncome = incomeSnapshot.data ?? 0.0;
                          return amountDisplayer(
                            amount1: totalIncome - totalExpense,
                          );
                        }
                      },
                    );
                  }
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder<double>(
              future: getTotalExpenseAmount(),
              builder: (context, expenseSnapshot) {
                if (expenseSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (expenseSnapshot.hasError) {
                  return Text("Error: ${expenseSnapshot.error}");
                } else {
                  double totalExpense = expenseSnapshot.data ?? 0.0;
                  return FutureBuilder<double>(
                    future: getTotalIncomeAmount(),
                    builder: (context, incomeSnapshot) {
                      if (incomeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (incomeSnapshot.hasError) {
                        return Text("Error: ${incomeSnapshot.error}");
                      } else {
                        double totalIncome = incomeSnapshot.data ?? 0.0;
                        print("Total Expense: $totalExpense");
                        print("Total Income: $totalIncome");
                        return progressBar(
                          totalExpense: totalExpense,
                          totalIncome: totalIncome,
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: expenseButton(
                  refreshCallback1: refresh,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: incomeButton(
                  refreshCallback4: refresh,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
