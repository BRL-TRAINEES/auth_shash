import 'package:authappsecond/login.dart';
import 'package:authappsecond/signup.dart';

import 'wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isVerified = false;
  String verificationMessage = '';

  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  sendVerifyLink() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().then((value) {
        Get.snackbar('Verification Link Sent', 'Please check your email.');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'User not registered. Please sign up first.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  reload() async {
  await FirebaseAuth.instance.currentUser!.reload();
  final user = FirebaseAuth.instance.currentUser!;
  setState(() {
    isVerified = user.emailVerified;
    if (!isVerified) {
      verificationMessage = 'Please verify your email first.';
    } else {
      Get.offAll(Login()); 
    }
  });
}



  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Email Verification", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.orange,
      leading: IconButton( // Add back button
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Get.offAll(SignUp()); // Navigate back to SignUp page
        },
      ),
    ),
    backgroundColor: Colors.black,
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.mail_outline, size: 80, color: Colors.orange),
            ),
            SizedBox(height: 20.0),
            Text(
              "Verify your email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: reload,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'I have verified',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            if (verificationMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  verificationMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}}
