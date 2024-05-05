  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:wealthwatch/Components/mybutton.dart";
import "package:wealthwatch/Components/mytextfield.dart";

  class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text editing controllers
  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  //sign user in
  void signUserIn() async
  {
    //buffer circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),);
    },);

    //try signing in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    );
    //pop buffer circle
    Navigator.pop(context);

    }on FirebaseAuthException catch (e){
    //pop buffer circle
    Navigator.pop(context);

    // //wrong email
    // if (e.code == 'user-not-found')
    // {
    // print("user not found");
    // //wrongEmailMessage();
    // }
    // //wrong password
    // else if (e.code == 'wrong-password')
    // {
    // print("wrong password");
    // //wrongPasswordMessage();
    // }
    // else
    print("Error Logging in! Check if you've entered correct credentials!");
    errorPopped();
    
   }

  }


void errorPopped()
{
  showDialog(context: context, builder: (context) {
      return const AlertDialog(title:Text('Incorrect Credentials'),);
    },);
}
//Google has added email enumeration protection, which you will need to turn off (Not recommended),
//because attackers may try to see if your app has that email address associated with your app.

//   //wrong email message method
//   void wrongEmailMessage(){
//     showDialog(context: context, builder: (context) {
//       return const AlertDialog(title:Text('Incorrect Email'),);
//     },);
//   }

// //wrong password message method
//   void wrongPasswordMessage(){
//     showDialog(context: context, builder: (context) {
//       return const AlertDialog(title:Text('Incorrect Password'),);
//     },);
//   }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Color.fromARGB(255, 137, 178, 178),
        body: SafeArea(
          child:Center(
            child: SingleChildScrollView(
              physics:ClampingScrollPhysics(),
              child: Column(
                children: [
                  //SizedBox(height: 20),
                  
                  Icon(Icons.home,
                  size:100,),
              
                  SizedBox(height: 50),

                  Text("Welcome to WealthWatch",
                  style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 74, 74, 72)),),
                  
                  SizedBox(height: 40,),
              
                  MyTextField(controller:emailController,hintText: "Username", obscureText: false),
              
                  SizedBox(height: 15),
              
                  MyTextField(controller:passwordController,hintText: "Password", obscureText: true),
              
                  SizedBox(height: 20 ),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      
                      children: [
                        Text("Forgot Password?",
                        style: TextStyle(color: Color.fromARGB(255, 76, 75, 75)),),
                      ],
                    ),
                  ),
              
                  SizedBox(height: 40),
              
                  MyButton(onTap: signUserIn, word: "Sign In",),
              
                  SizedBox(height: 80),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text("Register Here", style: TextStyle(color: const Color.fromARGB(255, 49, 68, 78)),))
                    ],
                  ),

                  SizedBox(height: 20,)

                  
              
                ],
              ),
            ),
          )
        ),
      );
  }
}