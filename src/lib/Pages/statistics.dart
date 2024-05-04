import 'package:flutter/material.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<double> weeklySymmary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    98.98,
    88.4,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SizedBox(
          height: 400,
          child: MyBarGraph(
            weeklySummary: weeklySymmary,
          ),
        ),
      ),
    );
  }
}
