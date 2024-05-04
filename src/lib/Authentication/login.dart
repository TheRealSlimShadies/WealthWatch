  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

  import "package:flutter/material.dart";
  import "package:flutter/services.dart";
  import "package:flutter/widgets.dart";
  import "package:wealthwatch/Components/mybutton.dart";
  import "package:wealthwatch/Components/mytextfield.dart";

  class Login extends StatelessWidget {
    Login({super.key});

    void signUserIn()
    {

    }

    @override
    Widget build(BuildContext context) {
      final emailController = TextEditingController();
      final passwordController = TextEditingController();

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
              
                  MyButton(onTap:() {
                    Navigator.pushNamed(context, '/homepage');
                  },
                  
                  //signUserIn
                  ),
              
                  SizedBox(height: 80),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member? "),
                      Text("Register Here", style: TextStyle(color: const Color.fromARGB(255, 49, 68, 78)),)
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