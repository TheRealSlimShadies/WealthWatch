// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String word;

  const MyButton({super.key, required this.onTap, required this.word});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(221, 28, 30, 30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(word,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16))),
        ),
      ),
    );
  }
}
