import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';


class pieChart extends StatefulWidget {
  final VoidCallback? refreshCallBack10;
  const pieChart({super.key, required this.refreshCallBack10});
  @override
  State<pieChart> createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
  final List<BoxShadow> customBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 9,
      blurRadius: 7,
      offset: Offset(0, 3),
    ),
  ];

Future<double> getTotalExpenseAmountForCategory(String categoryName) async {

  String uid = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('auth id', isEqualTo: uid).get();

  DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

  String id= documentSnapshot.id;

  CollectionReference categoryRef = FirebaseFirestore.instance.collection('users').doc(id) .collection('ExpenseCategories').doc(categoryName).collection('expenseList');

  // Query the expenseList collection to get all documents
  QuerySnapshot querySnapshot1 = await categoryRef.get();

  double totalAmount = 0;

 // Loop through each document in the query result
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot1.docs) {
    // Get the data map from the document
    Map<String, dynamic>? data = documentSnapshot.data() as Map<String,dynamic>;

    // Check if the data map is not null and contains the "amount" field
    if (data != null && data.containsKey('amount')) {
      var amount = data['amount'];
      if (amount is int) {
        totalAmount += amount.toDouble();
      }
      else if(amount is double)
      {
        totalAmount += amount;
      }
    }
  }
  return totalAmount;
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getTotalExpenseAmountForCategory('catFood'),
        getTotalExpenseAmountForCategory('catTransportation'),
        getTotalExpenseAmountForCategory('catEntertainment'),
        getTotalExpenseAmountForCategory('catHousing'),
        getTotalExpenseAmountForCategory('catMiscellaneous'),
        getTotalExpenseAmountForCategory('catHealth'),
        getTotalExpenseAmountForCategory('catEducation'),
      ]),
      builder: (context,snapshot){
        if (snapshot.connectionState== ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.hasError)
        {
          return Center(child: Text("Error: ${snapshot.error}"),);
        }
        else if (snapshot.hasData)
        {
          List<double> totals= snapshot.data!;
           return PieChart(
            swapAnimationDuration: Duration(seconds: 1),
            swapAnimationCurve: Curves.easeIn,
            PieChartData(
              pieTouchData: PieTouchData(
                enabled: true,
                touchCallback: (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                  PieChartSectionData? sectionIndex = pieTouchResponse?.touchedSection?.touchedSection;
                  String caseTitle = sectionIndex!.title;
                  //List<Expense>? the_list = getExpenseListForSection(caseTitle);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => expenseWindow(
                        categoryName: caseTitle,
                        refreshCallBack11: widget.refreshCallBack10,
                      ),
                    ),
                  );
                },
              ),
              sections: [
                PieChartSectionData(
                  value: totals[0],
                  color: Color(0xFF9A77CF),
                  radius: 180,
                  showTitle: false,
                  title: 'catFood',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 118, 69, 191),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.fastfood_outlined,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[1],
                  color: Color(0xFF543884),
                  radius: 180,
                  showTitle: false,
                  title: 'catTransportation',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 73, 36, 137),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.train_sharp,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[2],
                  color: Color(0xFF262254),
                  radius: 180,
                  showTitle: false,
                  title: 'catEntertainment',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 28, 23, 82),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.movie_creation_rounded,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[3],
                  color: Color(0xFFA13670),
                  radius: 180,
                  showTitle: false,
                  title: 'catHousing',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 157, 29, 99),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.house_rounded,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[4],
                  color: Color(0xFFEC4176),
                  radius: 180,
                  showTitle: false,
                  title: 'catMiscellaneous',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 249, 42, 107),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.auto_awesome_mosaic,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[5],
                  color: Color(0xFFFFA45E),
                  radius: 180,
                  showTitle: false,
                  title: 'catHealth',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 252, 148, 69),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.local_hospital_outlined,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
                PieChartSectionData(
                  value: totals[6],
                  color: Color(0xFFFCE38A),
                  radius: 180,
                  showTitle: false,
                  title: 'catEducation',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 254, 217, 84),
                      boxShadow: customBoxShadow,
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                    ),
                  ),
                  badgePositionPercentageOffset: 0.96,
                ),
              ],
              sectionsSpace: 0,
              centerSpaceRadius: 0,
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}

List<Expense>? getExpenseListForSection(String caseTitle) {
  switch (caseTitle) {
    case 'Food':
      return catFood.expenseListItems;
    case 'Transportation':
      return catTransportation.expenseListItems;
    case 'Entertainment':
      return catEntertainment.expenseListItems;
    case 'Housing':
      return catHousing.expenseListItems;
    case 'Miscellaneous':
      return catMiscellaneous.expenseListItems;
    case 'Health':
      return catHealth.expenseListItems;
    case 'Education':
      return catEducation.expenseListItems;
  }
  return [];
}
 