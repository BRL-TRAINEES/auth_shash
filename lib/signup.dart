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

  void checkPasswordStrength(String password) { // password strength
    if (password.length > 8 || (password.length > 6 && RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password))) {
      setState(() {
        passwordStrength = 'Strong Password ;)';
      });
    } else {
      setState(() {
        passwordStrength = 'Weak Password :(';
      }
      );
    }


  }

  signup() 
  async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    Get.offAll(Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(hintText: 'Email Here'),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(hintText: 'Password Here'),
            onChanged: checkPasswordStrength,
            obscureText: true, // hiding in black dots 
          ),
          Text(
            passwordStrength,
            style: TextStyle(
              color: passwordStrength == 'Weak Password :(' 
                  ? const Color.fromARGB(255, 229, 57, 44) 
                  : const Color.fromARGB(255, 78, 233, 106), 
            ),
          ),
          ElevatedButton(onPressed: (() => signup()), child: Text('Sign Up')),
        ],
      ),
    );
  }
}
