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
   final catFoodupdater = catFood;
  final catTransportationupdater = catTransportation;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      
      swapAnimationDuration: Duration(seconds: 2),
      swapAnimationCurve: Curves.linear,
      PieChartData(
        sections: [
          PieChartSectionData(
            
            value: catFood.getTotalExpenseAmount().toDouble(),
            color: Colors.blue,
            radius: 180,
          ),
          PieChartSectionData(
            value: catTransportation.getTotalExpenseAmount().toDouble(),
            color: const Color.fromARGB(255, 72, 243, 33),
            radius: 180,
          ),
          PieChartSectionData(
            value: catHousing.getTotalExpenseAmount().toDouble(),
            color: Color.fromARGB(255, 227, 85, 24),
            radius: 180,
          ),
          PieChartSectionData(
            value: catEntertainment.getTotalExpenseAmount().toDouble(),
            color: Color.fromARGB(255, 184, 242, 12),
            radius: 180,
          ),
          PieChartSectionData(
            value: catEducation.getTotalExpenseAmount().toDouble(),
            color: Color.fromARGB(255, 251, 0, 255),
            radius: 180,
          ),
          PieChartSectionData(
            value: catMiscellaneous.getTotalExpenseAmount().toDouble(),
            color: Color.fromARGB(255, 137, 0, 43),
            radius: 180,
          ),
          PieChartSectionData(
            value: catHealth.getTotalExpenseAmount().toDouble(),
            color: Color.fromARGB(255, 247, 2, 2),
            radius: 180,
          ),

        ],
        sectionsSpace: 0,
        centerSpaceRadius: 0,
      ),
    );
  }
}
