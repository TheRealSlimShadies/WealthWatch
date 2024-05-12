import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/themes/theme_provider.dart';
import 'package:wealthwatch/Graphs/bar_chart.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    List<double> weeklySummary = [
      4.40,
      2.50,
      42.42,
      10.50,
      100.20,
      98.98,
      88.4,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor:
          themeData.colorScheme.secondary, // Use background color from theme
      body: Center(
        child: SizedBox(
          height: 400,
          child: MyBarGraph(
            weeklySummary: weeklySummary,
          ),
        ),
      ),
    );
  }
}
