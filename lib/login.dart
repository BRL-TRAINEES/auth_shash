import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false; // for the circular progress state

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Wrong email/password");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
        appBar: AppBar(
        title: Text("Login"),
    backgroundColor: Colors.blueGrey,
    ),
    body: Container(

    decoration: BoxDecoration(
    gradient: LinearGradient(colors:
     [
    Colors.blueGrey.shade500,

       Colors.blueGrey.shade200,
    ],

    ),
    ),
    child: Column(
    children: [
      SizedBox(height: 250,),

    TextField(
    controller: email,
    decoration: InputDecoration(hintText :'Email Here '  , filled:true,
      fillColor: Colors.white,),

    ),
    TextField(
    controller: password,
    decoration: InputDecoration(hintText :'Password Here',filled:true,fillColor: Colors.white),
    obscureText: true,
    ),
    ElevatedButton(onPressed: (()=>signIn()), child: Text('Login')),
    SizedBox(height: 30,),
    ElevatedButton(onPressed: (()=>Get.to(SignUp())), child: Text('New? Register Here')),
    SizedBox(height: 30,),
    ElevatedButton(onPressed: (()=>Get.to(Forgot())), child: Text('Forgot Password?')),

    ],


    ),

    ));
  }
}

