// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Graphs/pieChart.dart';

class categoryWindow extends StatefulWidget {
  final String name;
  final VoidCallback? refreshCallBack13;
  const categoryWindow({
    super.key,
    required this.name,
    required this.refreshCallBack13,
  });

  @override
  State<categoryWindow> createState() => categoryWindowState();
}

class categoryWindowState extends State<categoryWindow> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name == "Expense") {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black54,
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
            iconTheme: IconThemeData(color: Colors.white)),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF9A77CF),
                ),
                child: ListTile(
                  title: Text('Food'),
                  trailing: Text('${allData?[0]}'),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => expenseWindow(
                          categoryName: 'catFood',
                          refreshCallBack11: widget.refreshCallBack13,
                          refresh: refresh,
                        ),
                      ),
                    );
                    if (result == true) {
                      refresh();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFFCE38A)),
                child: ListTile(
                  title: Text('Education'),
                  trailing: Text('${allData?[6]}'),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catEducation',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF262254)),
                child: ListTile(
                  title: Text(
                    'Entertainment',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '${allData?[2]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catEntertainment',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFFFA45E)),
                child: ListTile(
                  title: Text('Health'),
                  trailing: Text('${allData?[5]}'),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catHealth',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFA13670)),
                child: ListTile(
                  title: Text('Housing'),
                  trailing: Text('${allData?[3]}'),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catHousing',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF543884)),
                child: ListTile(
                  title: Text('Transportation',
                      style: TextStyle(color: Colors.white)),
                  trailing: Text(
                    '${allData?[1]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catTransportation',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFEC4176)),
                child: ListTile(
                  title: Text('Miscellaneous'),
                  trailing: Text('${allData?[4]}'),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => expenseWindow(
                                  categoryName: 'catMiscellaneous',
                                  refreshCallBack11: widget.refreshCallBack13,
                                  refresh: refresh,
                                )))
                  },
                ),
              ),
            )
          ]),
        ),
      );
    } else if (widget.name == 'Income') {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black54,
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
            iconTheme: IconThemeData(color: Colors.white)),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    tileColor: Colors.greenAccent,
                    title: Text("Deposit"),
                    trailing: Text('${catDeposit.getTotalIncomeAmount()}'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    tileColor: Colors.greenAccent,
                    title: Text("Salary"),
                    trailing: Text('${catSalary.getTotalIncomeAmount()}'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    tileColor: Colors.greenAccent,
                    title: Text("Rent"),
                    trailing: Text('${catRent.getTotalIncomeAmount()}'),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Text("Error 404"),
    );
  }
}
