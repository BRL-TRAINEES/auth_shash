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
  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  sendVerifyLink() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().then((value) {
        Get.snackbar('Verification Link Sent', 'Please Check Your Mail');
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
    await FirebaseAuth.instance.currentUser!.reload().then((value) {
      Get.offAll(Wrapper());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Verification")),
      body: Center(
        child: ElevatedButton(
          onPressed: reload,
          child: Text('I have verified'),
        ),
      ),
    );
  }
}
