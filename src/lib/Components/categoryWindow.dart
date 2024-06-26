import 'package:flutter/material.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';
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
            toolbarHeight: 60,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 27, 181, 198),
                      Color.fromARGB(255, 41, 62, 145)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
            ),
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
                  color: Color.fromARGB(255, 242, 93, 95),
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
                  color: Color.fromARGB(255, 33, 122, 201),
                ),
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
                    color: Color.fromARGB(255, 251, 131, 66)),
                child: ListTile(
                  title: Text(
                    'Entertainment',
                  ),
                  trailing: Text(
                    '${allData?[2]}',
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
                    color: Color.fromARGB(255, 1, 218, 152)),
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
                    color: Color.fromARGB(255, 246, 124, 158)),
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
                  color: Color.fromARGB(255, 82, 186, 211),
                ),
                child: ListTile(
                  title: Text(
                    'Transportation',
                  ),
                  trailing: Text(
                    '${allData?[1]}',
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
                    color: Color.fromARGB(255, 250, 200, 84)),
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
      print('Displaying Income Data: $allIncomeData');
      return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFCCFFAA), Color(0xFF1e5b53)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
            ),
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
                    title: Text("Deposit"),
                    trailing: Text('${allIncomeData?[0]}'),
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
                    title: Text("Salary"),
                    trailing: Text('${allIncomeData?[2]}'),
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
                    title: Text("Rent"),
                    trailing: Text('${allIncomeData?[1]}'),
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
