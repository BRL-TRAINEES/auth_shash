import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController email = TextEditingController();

  reset() async {
    // Trim whitespace from the email input
    String emailInput = email.text.trim();

    try {
      // Check if the email exists in the database
      List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailInput);

      if (signInMethods.isEmpty) {
        // If no sign-in methods are found, the user is not registered
        Get.snackbar('Error', 'User with this email not found. Please register first.');
      } else {
        // If the email is registered, send the password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailInput);
        Get.snackbar('Success', 'Link has been sent to your email.');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Invalid Email');
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password?")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey.shade500,
            Colors.blueGrey.shade200,
          ]),
        ),
        child: Column(
          children: [
            SizedBox(height: 290),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email Here',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0), // Add some space between the TextField and button
            ElevatedButton(
              onPressed: reset,
              child: Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
