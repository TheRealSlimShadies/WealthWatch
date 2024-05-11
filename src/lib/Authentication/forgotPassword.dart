// ignore_for_file: prefer_const_constructors

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:wealthwatch/Components/mybutton.dart";
import "package:wealthwatch/Components/mytextfield.dart";

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {

  final emailController= TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }



  Future resetPassword () async
  {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Password reset link sent! Check your email."),
        );
      },
    );
    } on FirebaseAuthException catch (e)
    {
    print(e);
    
    // Checking the error code to display appropriate error message
    // if (e.code == 'invalid-email')
    // {
    //   errorPopped("Badly formatted email.");
    // } 
    // else if (e.code == 'user-not-found')
    // {
    //   errorPopped('An error occured. The entered Email is not registered.');
    // }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
    );
  }
}

// void errorPopped(String word)
// {
//   showDialog(context: context, builder: (context) {
//       return AlertDialog(title:Text(word),);
//     },);
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 104, 158),
        elevation: 0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
      
          Padding(padding: EdgeInsets.symmetric(horizontal:20),
          child: Text("Enter your email and we'll send your password reset link.",
            textAlign: TextAlign.center,) 
            ),
          
          SizedBox(height:20),
      
          MyTextField(controller:emailController,hintText: "Email", obscureText: false),
      
          SizedBox(height: 30),

          MyButton(onTap: resetPassword , word: 'Reset Password'),
        ],
      ),
    );
  }
}