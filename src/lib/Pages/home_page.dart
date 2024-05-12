// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Buttons/expenseButton.dart';
import 'package:wealthwatch/Buttons/incomeButton.dart';
import 'package:wealthwatch/Graphs/pieChart.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout_outlined)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(197, 255, 255, 255),
        child: Center(
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 70,
                ),
              ),
              Text(
                user.email!,
                style: TextStyle(fontSize: 20, fontFamily: "Arial"),
              ),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet, size: 30),
                  title: Text(
                    'Statistics',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/statistic');
                  }),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet, size: 30),
                  title: Text(
                    'Co-Fund',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cofund');
                  }),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet, size: 30),
                  title: Text(
                    'Calendar',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendar');
                  }),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 40, top: 70),
                  leading: Icon(Icons.account_balance_wallet, size: 30),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 17),
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
          Expanded(
            child: pieChart(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(30),
                child: expenseButton(
                  refreshCallback1: refresh,
                ),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(30),
                child: incomeButton(),
              ))
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
