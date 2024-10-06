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


  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isloading=false;
   signIn()async{
    setState((){
      isloading=true;});
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Wrong email/password");
    }
    setState((){
      isloading=false;});
    }
  


  @override
  Widget build(BuildContext context) {
    return isloading?
    Center(child: CircularProgressIndicator(),): Scaffold(

     appBar: AppBar(title :Text("Login"),),


     body:Column(
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(hintText :'Email Here '),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(hintText :'Password Here'),
          obscureText: true,
        ),
        ElevatedButton(onPressed: (()=>signIn()), child: Text('Login')),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: (()=>Get.to(SignUp())), child: Text('New? Register Here')),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: (()=>Get.to(Forgot())), child: Text('Forgot Password?')),

      ],


     ),
     
    );
  }
}
