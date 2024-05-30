  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:wealthwatch/Components/mybutton.dart";
import "package:wealthwatch/Components/mytextfield.dart";
import "package:wealthwatch/Data/Expense.dart";

  class Register extends StatefulWidget {
  final Function()? onTap;
  
  const Register({super.key, required this.onTap});


  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  //text editing controllers
  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  final confirmpasswordController = TextEditingController();

  
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();

  @override
  void dispose() {
    //TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  

  //validate the input field
  void validateField(){
  if(_formkey.currentState!.validate()){
    print("Validated correctly.....");
  //sign user up
    signUserUp();

  }
  else{
    
  print("Empty field..."); 
      
  }
  }


  //sign user up
  Future signUserUp() async
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
      //create the user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
      );

      //taking the auth id for current user. using this, i query the docs and find the first name of current user
      String uid=FirebaseAuth.instance.currentUser!.uid;

      //add the user details
      addUserDetail(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        catFood.expenseListItems,
        catTransportation.expenseListItems,
        catEducation.expenseListItems,
        catMiscellaneous.expenseListItems,
        catHealth.expenseListItems,
        catEntertainment.expenseListItems,
        catHousing.expenseListItems,
        catDeposit.incomeListItems,
        catRent.incomeListItems,
        catSalary.incomeListItems,
        uid,);

 
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

  Future<void> addUserDetail(String firstName, String lastName, String email, List catfood, List cattransportation,
  List cateducation, List catmiscellaneous, List cathealth, List catentertainment, List cathousing, List catdeposit, List catrent, List catsalary ,String uid) async
  {
    
    DocumentReference userRef= await FirebaseFirestore.instance.collection('users').add({
    'first name': firstName ,
    'last name' : lastName ,
    'email' : email,
    'auth id' : uid,
    });


  // adding expense categories to the user's document
  await userRef.collection('ExpenseCategories').doc('catFood').set({});
  await userRef.collection('ExpenseCategories').doc('catTransportation').set({});
  await userRef.collection('ExpenseCategories').doc('catEducation').set({});
  await userRef.collection('ExpenseCategories').doc('catMiscellaneous').set({});
  await userRef.collection('ExpenseCategories').doc('catHealth').set({});
  await userRef.collection('ExpenseCategories').doc('catEntertainment').set({});
  await userRef.collection('ExpenseCategories').doc('catHousing').set({});

  // // trying to add expenses to each category's 'expenseList' subcollection
  // await addExpensesToCategory(userRef, 'catFood', catFood.expenseListItems);
  // await addExpensesToCategory(userRef, 'catTransportation', catTransportation.expenseListItems);
  // await addExpensesToCategory(userRef, 'catEducation', catEducation.expenseListItems);
  // await addExpensesToCategory(userRef, 'catMiscellaneous', catMiscellaneous.expenseListItems);
  // await addExpensesToCategory(userRef, 'catHealth', catHealth.expenseListItems);
  // await addExpensesToCategory(userRef, 'catEntertainment', catEntertainment.expenseListItems);
  // await addExpensesToCategory(userRef, 'catHousing', catHousing.expenseListItems);


// adding income categories to the user's document
  await userRef.collection('IncomeCategories').doc('catDeposit').set({});
  await userRef.collection('IncomeCategories').doc('catRent').set({});
  await userRef.collection('IncomeCategories').doc('catSalary').set({});
  

  // // trying to add incomes to each category's 'expenseList' subcollection
  // await addIncomesToCategory(userRef, 'catDeposit', catDeposit.incomeListItems);
  // await addIncomesToCategory(userRef, 'catRent', catRent.incomeListItems);
  // await addIncomesToCategory(userRef, 'catSalary', catSalary.incomeListItems);


  print("user details added successfully..........");
}

// Future<void> addExpensesToCategory(DocumentReference userRef, String categoryName, List<Expense> expenses) async {
//   CollectionReference categoryRef = userRef.collection('ExpenseCategories').doc(categoryName).collection('expenseList');
//   for (var expense in expenses) {
//     await categoryRef.add({
//       'name': expense.name,
//       'amount': expense.expenseAmount,
//       'date': expense.datetime,
//     });
//   }
// }

// Future<void> addIncomesToCategory(DocumentReference userRef, String categoryName, List<Income> incomes) async {
//   CollectionReference categoryRef = userRef.collection('IncomeCategories').doc(categoryName).collection('incomeList');
//   for (var income in incomes) {
//     await categoryRef.add({
//       'amount': income.incomeAmount,
//     });
//   }
// }



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
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formkey,
                child: Column(
                  children: [
                    //SizedBox(height: 20),
                    
                    Icon(Icons.home,
                    size:70,),
                
                    SizedBox(height: 50),
                
                    Text("Create Your Account",
                    style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 74, 74, 72)),),
                    
                    SizedBox(height: 40,),
                
                    MyTextField(controller:firstNameController,hintText: "First Name", obscureText: false),
                
                    SizedBox(height: 15,),
                
                    MyTextField(controller:lastNameController,hintText: "Last Name", obscureText: false),
                
                    SizedBox(height: 15,),
                
                    MyTextField(controller:emailController,hintText: "User Name", obscureText: false),
                
                    SizedBox(height: 15),
                
                    MyTextField(controller:passwordController,hintText: "Password", obscureText: true),
                
                    SizedBox(height: 15 ),
                
                    MyTextField(controller:confirmpasswordController,hintText: "Confirm Password", obscureText: true),
                
                    SizedBox(height: 60),
                
                    MyButton(onTap:validateField, word: "Sign Up",),
                
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
            ),
          )
        ),
      );
  }
}