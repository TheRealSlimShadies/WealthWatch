import "package:flutter/material.dart";

class coFund extends StatelessWidget {
  const coFund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CoFund",
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.red[500],
        centerTitle: true,
        
      ),
    );
  }
}