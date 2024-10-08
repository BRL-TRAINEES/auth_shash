import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wrapper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String passwordStrength = '';
  String errorMessage = ''; // Variable to store error messages

  void checkPasswordStrength(String password) {
    if (password.length > 8 || (password.length > 6 && RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password))) {
      setState(() {
        passwordStrength = 'Strong Password ;)';
      });
    } else {
      setState(() {
        passwordStrength = 'Weak Password :(';
      });
    }
  }

  signup() async {
    String emailText = email.text.trim(); // Trim email input

    // Check if the email is valid
    if (!emailText.contains('@') || !emailText.contains('.')) {
      setState(() {
        errorMessage = 'Please use a valid email address!';
      });
      return; // Stop the signup process
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText,
        password: password.text,
      );
      Get.offAll(Wrapper());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'User not registered. Please sign up first.');

      }
      setState(() {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already registered!';
        } else {
          errorMessage = 'An error occurred. Please try again.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade500,
              Colors.blueGrey.shade200,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 200),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email Here',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password Here',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: checkPasswordStrength,
              obscureText: true,
            ),
            Text(
              passwordStrength,
              style: TextStyle(
                color: passwordStrength == 'Weak Password :('
                    ? const Color.fromARGB(255, 229, 57, 44)
                    : const Color.fromARGB(255, 78, 233, 106),
              ),
            ),
            if (errorMessage.isNotEmpty) // Display error message if present
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: signup,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
