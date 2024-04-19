import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class pieChart extends StatefulWidget {
  const pieChart({super.key});

  @override
  State<pieChart> createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 20,
            color: Colors.blue,
            radius: 180,

            
          ),
          PieChartSectionData(
            value: 40,
            color: const Color.fromARGB(255, 72, 243, 33),
            radius: 180,

            
          )
        ],
        sectionsSpace: 0,
        centerSpaceRadius:0,
        
      ),
      
    );
  }
}