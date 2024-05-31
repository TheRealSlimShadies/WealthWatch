import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwatch/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {


Future<void> deleteUserAccount(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // deleting user from Firestore
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('auth id', isEqualTo: user.uid)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.delete();
        }

        // deleting from FirebaseAuth
        await user.delete();
        
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        print("Error: $e");
      }
    } 
    else 
    {
    print("No user currently signed in.");
    }
  }

  void DeleteUserPopUpBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deleting Account..."),
          content: Text("Do you want to permanently delete your account?"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await deleteUserAccount(context);

                print("Navigating to login screen");
                if(mounted)
                {
                  print("working well.............");
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false); // redirecting to login screen and removing any associated routes.
                }
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor:  Color.fromARGB(255, 90, 88, 88),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Theme"),
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) => Provider.of<ThemeProvider>(context,
                            listen: false)
                        .toggleTheme(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => DeleteUserPopUpBox(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 23),
                child: Center(
                  child: Text("Delete Account"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}