// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:wealthwatch/Components/mybutton.dart";
import "package:wealthwatch/Components/mytextfield.dart";
//import "package:wealthwatch/themes/theme_provider.dart";
//import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //sign user in
  void signUserIn() async {
    //buffer circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //pop buffer circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop buffer circle
      Navigator.pop(context);

      //wrong email
      if (e.code == 'user-not-found') {
        print("user not found");
        errorPopped(e.code);
        //wrongEmailMessage();
      }
      //wrong password
      else if (e.code == 'wrong-password') {
        print("wrong password");
        errorPopped(e.code);
        //wrongPasswordMessage();
      } else
        print("Error Logging in! Check if you've entered correct credentials!");
      //errorPopped("Check if you've entered correct credentials!");
    }
  }

  void errorPopped(String word) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(word),
        );
      },
    );
  }
//Google has added email enumeration protection, which you will need to turn off (Not recommended),
//because attackers may try to see if your app has that email address associated with your app.

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    //final themeData = themeProvider.themeData;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 171, 171),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              //SizedBox(height: 20),

              Icon(
                Icons.home,
                size: 100,
              ),

              SizedBox(height: 50),

              Text(
                "Welcome to WealthWatch",
                style: TextStyle(
                    fontSize: 18, color: const Color.fromARGB(255, 74, 74, 72)),
              ),

              SizedBox(
                height: 40,
              ),

              MyTextField(
                controller: emailController,
                hintText: "Username",
                obscureText: false,
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),

              SizedBox(height: 15),

              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgotPassword');
                      },
                      child: Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 76, 75, 75)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              MyButton(
                onTap: signUserIn,
                word: "Sign In",
              ),

              SizedBox(height: 80),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member? "),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Here",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 49, 68, 78)),
                      ))
                ],
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
