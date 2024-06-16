//import 'dart:ffi';
//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/Data/Expense.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';

List<double>? allData;
List<double>? allIncomeData;

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
      offset: const Offset(0, 3),
    ),
  ];

  Future<double> getTotalAmountForCategory(String categoryName, String collectionName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('auth id', isEqualTo: uid)
        .get();

    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

    String id = documentSnapshot.id;

    CollectionReference categoryRef = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection(collectionName)
        .doc(categoryName)
        .collection(collectionName == 'ExpenseCategories'? 'expenseList' : 'incomeList');

    // Query the expenseList collection to get all documents
    QuerySnapshot querySnapshot1 = await categoryRef.get();

    double totalAmount = 0;

    print('Fetching data for $categoryName in $collectionName');

    // Loop through each document in the query result
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot1.docs) {
      // Get the data map from the document
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Check if the data map is not null and contains the "amount" field
      if (data != null && data.containsKey('amount')) {
        var amount = data['amount'];
        if (amount is int) {
          totalAmount += amount.toDouble();
        } else if (amount is double) {
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
        getTotalAmountForCategory('catFood','ExpenseCategories'),
        getTotalAmountForCategory('catTransportation','ExpenseCategories'),
        getTotalAmountForCategory('catEntertainment','ExpenseCategories'),
        getTotalAmountForCategory('catHousing','ExpenseCategories'),
        getTotalAmountForCategory('catMiscellaneous','ExpenseCategories'),
        getTotalAmountForCategory('catHealth','ExpenseCategories'),
        getTotalAmountForCategory('catEducation','ExpenseCategories'),
                
        getTotalAmountForCategory('catDeposit', 'IncomeCategories'),
        getTotalAmountForCategory('catRent', 'IncomeCategories'),
        getTotalAmountForCategory('catSalary', 'IncomeCategories')


      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {

          List<double> allTotals = snapshot.data!;
          allData = allTotals.sublist(0,7); //expense amts
          allIncomeData= allTotals.sublist(7); //income amts

          print('Expense Data: $allData');
          print('Income Data: $allIncomeData');




          return PieChart(
            swapAnimationDuration: Duration(seconds: 10),
            swapAnimationCurve: Curves.easeIn,
            PieChartData(
              pieTouchData: PieTouchData(
                enabled: true,
                touchCallback:
                    (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                  PieChartSectionData? sectionIndex =
                      pieTouchResponse?.touchedSection?.touchedSection;
                  String caseTitle = sectionIndex!.title;
                  //List<Expense>? the_list = getExpenseListForSection(caseTitle);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => expenseWindow(
                        categoryName: caseTitle,
                        refreshCallBack11: widget.refreshCallBack10,
                        refresh: () {},
                      ),
                    ),
                  );
                },
              ),
              sections: [
                PieChartSectionData(
                  value: allData![0],
                  color: Color.fromARGB(255, 242, 93, 95),
                  radius: 180,
                  showTitle: false,
                  title: 'catFood',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 242, 93, 95),
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
                  value: allData![1],
                  color: Color.fromARGB(255, 82, 186, 211),
                  radius: 180,
                  showTitle: false,
                  title: 'catTransportation',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 82, 186, 211),
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
                  value: allData![2],
                  color: Color.fromARGB(255, 251, 131, 66),
                  radius: 180,
                  showTitle: false,
                  title: 'catEntertainment',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 251, 131, 66),
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
                  value: allData![3],
                  color: Color.fromARGB(255, 246, 124, 158),
                  radius: 180,
                  showTitle: false,
                  title: 'catHousing',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 246, 124, 158),
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
                  value: allData![4],
                  color: Color.fromARGB(255, 250, 200, 84),
                  radius: 180,
                  showTitle: false,
                  title: 'catMiscellaneous',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 250, 200, 84),
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
                  value: allData![5],
                  color: Color.fromARGB(255, 1, 218, 152),
                  radius: 180,
                  showTitle: false,
                  title: 'catHealth',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 1, 218, 152),
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
                  value: allData![6],
                  color: Color.fromARGB(255, 33, 122, 201),
                  radius: 180,
                  showTitle: false,
                  title: 'catEducation',
                  badgeWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 33, 122, 201),
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
