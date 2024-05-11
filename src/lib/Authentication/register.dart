  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:wealthwatch/Components/mybutton.dart";
import "package:wealthwatch/Components/mytextfield.dart";

  class Register extends StatefulWidget {
  final Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //text editing controllers
  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  final confirmpasswordController = TextEditingController();

  //sign user up
  void signUserUp() async
  {
    //buffer circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),);
    },);

    //checking confirmation of password
    try{
      if(passwordController.text == confirmpasswordController.text)
      {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
      );
      }
      else
      {
      //error message for when passwords don't match
      errorPopped("Passwords do not match");
      return;
      }

       Navigator.pop(context);

    }on FirebaseAuthException catch (e){
   

    Navigator.pop(context);

    if (e.code == 'invalid-email') {
      errorPopped(e.code);
    }
   }

  }


// Function to show error dialog
void errorPopped(String word)
{
  showDialog(context: context, builder: (context) {
      return AlertDialog(title:Text(word),);
    },);
}


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
                  size:70,),
              
                  SizedBox(height: 50),

                  Text("Create Your Account",
                  style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 74, 74, 72)),),
                  
                  SizedBox(height: 40,),
              
                  MyTextField(controller:emailController,hintText: "Username", obscureText: false),
              
                  SizedBox(height: 15),
              
                  MyTextField(controller:passwordController,hintText: "Password", obscureText: true),
              
                  SizedBox(height: 15 ),

                  MyTextField(controller:confirmpasswordController,hintText: "Confirm Password", obscureText: true),
              
                  SizedBox(height: 60),
              
                  MyButton(onTap: signUserUp, word: "Sign Up",),
              
                  SizedBox(height: 80),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text("Sign In", style: TextStyle(color: const Color.fromARGB(255, 49, 68, 78)),))
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