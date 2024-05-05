import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wealthwatch/data.dart/Expense.dart';



class pieChart extends StatefulWidget {
  const pieChart({super.key});

  
  @override
  State<pieChart> createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
 
  late var randomvariable = 0;
  final catFoodupdater = catFood;
  final catTransportationupdater = catTransportation;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      
      swapAnimationDuration: Duration(seconds: 2),
      swapAnimationCurve: Curves.easeIn,
      PieChartData(
        sections: [
          PieChartSectionData(
            
            value: catFoodupdater.getTotalExpenseAmount().toDouble(),
            color: Colors.blue,
            radius: 180,
          ),
          PieChartSectionData(
            value: catTransportationupdater.getTotalExpenseAmount().toDouble(),
            color: const Color.fromARGB(255, 72, 243, 33),
            radius: 180,
          ),
          PieChartSectionData(
            value: 0,
            color: Color.fromARGB(255, 227, 85, 24),
            radius: 180,
          )
        ],
        sectionsSpace: 0,
        centerSpaceRadius: 0,
      ),
    );
  }
}
