import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/data.dart/Expense.dart';
import 'package:wealthwatch/Components/expenseWindow.dart';

class pieChart extends StatefulWidget {
  const pieChart({super.key});

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

  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationDuration: Duration(seconds: 1),
      swapAnimationCurve: Curves.easeIn,
      PieChartData(
        pieTouchData: PieTouchData(
            enabled: true,
            touchCallback:
                (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
              PieChartSectionData? sectionIndex =
                  pieTouchResponse!.touchedSection!.touchedSection;
              String caseTitle = sectionIndex!.title;
              List<Expense>? the_list = getExpenseListForSection(caseTitle);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => expenseWindow(
                            listedExpense: the_list!,
                          )));
            }),
        sections: [
          PieChartSectionData(
              value: catFood.getTotalExpenseAmount().toDouble(),
              color: Color(0xFF9A77CF),
              radius: 180,
              showTitle: false,
              title: 'Food',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 118, 69, 191),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.fastfood_outlined,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catTransportation.getTotalExpenseAmount().toDouble(),
              color: Color(0xFF543884),
              radius: 180,
              showTitle: false,
              title: 'Transportation',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 73, 36, 137),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.train_sharp,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catEntertainment.getTotalExpenseAmount().toDouble(),
              color: Color(0xFF262254),
              radius: 180,
              showTitle: false,
              title: 'Entertainment',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 28, 23, 82),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.movie_creation_rounded,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catHousing.getTotalExpenseAmount().toDouble(),
              color: Color(0xFFA13670),
              radius: 180,
              showTitle: false,
              title: 'Housing',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 157, 29, 99),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catMiscellaneous.getTotalExpenseAmount().toDouble(),
              color: Color(0xFFEC4176),
              radius: 180,
              showTitle: false,
              title: 'Miscellaneous',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 249, 42, 107),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.auto_awesome_mosaic,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catHealth.getTotalExpenseAmount().toDouble(),
              color: Color(0xFFFFA45E),
              radius: 180,
              showTitle: false,
              title: 'Health',
              badgeWidget: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 252, 148, 69),
                    boxShadow: customBoxShadow),
                child: Icon(
                  Icons.local_hospital_outlined,
                  color: Colors.white,
                ),
              ),
              badgePositionPercentageOffset: 0.96),
          PieChartSectionData(
              value: catEducation.getTotalExpenseAmount().toDouble(),
              color: Color(0xFFFCE38A),
              radius: 180,
              showTitle: false,
              title: 'Education',
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
              badgePositionPercentageOffset: 0.96),
        ],
        sectionsSpace: 0,
        centerSpaceRadius: 0,
      ),
    );
  }
}

List<Expense>? getExpenseListForSection(caseTitle) {
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
  return null;
}
