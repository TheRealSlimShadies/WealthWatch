// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Buttons/expenseButton.dart';
import 'package:wealthwatch/Buttons/incomeButton.dart';
import 'package:wealthwatch/Components/amountDisplayer.dart';
import 'package:wealthwatch/Components/displaywidget.dart';
import 'package:wealthwatch/Components/progressBar.dart';
import 'package:wealthwatch/Graphs/pieChart.dart';
import 'package:wealthwatch/data/Expense.dart';
//import 'package:provider/provider.dart'
//import 'package:wealthwatch/themes/theme_provider.dart'

class Home extends StatefulWidget {
  Home({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  //final userData= FirebaseFirestore.instance.collection('users').get().then

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
                      signUserOut();
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
              ]
              //FirebaseAuth.instance.signOut();
              );
        });
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
                colors: [Color(0xFF4CA9DF), Color(0xFF292E91)],
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
              Text(
                user.email!,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Arial",
                    color: Theme.of(context).textTheme.bodyLarge!.color),
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
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(
                    Icons.account_balance_wallet,
                    size: 30,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    'Co-Fund',
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cofund');
                  }),
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
              displaywidget(
                amount: catEducation.getTotalExpenseAmount() +
                    catEntertainment.getTotalExpenseAmount() +
                    catFood.getTotalExpenseAmount() +
                    catHealth.getTotalExpenseAmount() +
                    catHousing.getTotalExpenseAmount() +
                    catMiscellaneous.getTotalExpenseAmount() +
                    catTransportation.getTotalExpenseAmount(),
                name: 'Expense',
              ),
              displaywidget(
                amount: catRent.getTotalIncomeAmount() +
                    catSalary.getTotalIncomeAmount() +
                    catDeposit.getTotalIncomeAmount(),
                name: 'Income',
              )
            ],
          ),
          Expanded(child: pieChart()),
          Padding(
              padding: EdgeInsets.all(5),
              child: amountDisplayer(
                  amount1: (catRent.getTotalIncomeAmount() +
                          catSalary.getTotalIncomeAmount() +
                          catDeposit.getTotalIncomeAmount()) -
                      (catEducation.getTotalExpenseAmount() +
                          catEntertainment.getTotalExpenseAmount() +
                          catFood.getTotalExpenseAmount() +
                          catHealth.getTotalExpenseAmount() +
                          catHousing.getTotalExpenseAmount() +
                          catMiscellaneous.getTotalExpenseAmount() +
                          catTransportation.getTotalExpenseAmount()))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: progressBar(
              totalExpense: catEducation.getTotalExpenseAmount() +
                  catEntertainment.getTotalExpenseAmount() +
                  catFood.getTotalExpenseAmount() +
                  catHealth.getTotalExpenseAmount() +
                  catHousing.getTotalExpenseAmount() +
                  catMiscellaneous.getTotalExpenseAmount() +
                  catTransportation.getTotalExpenseAmount(),
              totalIncome: catRent.getTotalIncomeAmount() +
                  catSalary.getTotalIncomeAmount() +
                  catDeposit.getTotalIncomeAmount(),
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
                child: incomeButton(refreshCallback4: refresh),
              )
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
