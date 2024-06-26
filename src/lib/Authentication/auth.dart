// ignore_for_file: prefer_const_constructors

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:wealthwatch/Authentication/LoginOrRegister.dart";
import "package:wealthwatch/Pages/home_page.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return Home();
          }

          //user not logged in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
