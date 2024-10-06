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


 TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  
   signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text,);
    Get.offAll(Wrapper());
   }



  @override
  Widget build(BuildContext context) {
     return Scaffold(

     appBar: AppBar(title :Text("Sign Up"),),
     body:Column(
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(hintText :'Email Here'),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(hintText :'Password Here'),
        ),
        ElevatedButton(onPressed: (()=>signup()), child: Text('Sign Up'))
      ]


     )
     
    );
  }
}