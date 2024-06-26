// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final TextStyle? textStyle;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "*Required";
          } else {
            return null;
          }
        },
        controller: controller,
        obscureText: obscureText,
        style: textStyle,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 246, 222, 222))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 65, 63, 63))),
            fillColor: Color.fromARGB(255, 255, 255, 255),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Color.fromARGB(255, 118, 118, 118))),
      ),
    );
  }
}
