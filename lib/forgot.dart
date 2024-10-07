import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}


class _ForgotState extends State<Forgot>

 {


   TextEditingController email=TextEditingController();
  
   reset()async{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    Get.snackbar('Success','Verification has been sent');

      
  
   }

   
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     appBar: AppBar(title :Text("Forgot password?"),),
     body:Container(
       decoration: BoxDecoration(
       gradient: LinearGradient(colors:
       [
       Colors.blueGrey.shade500,

       Colors.blueGrey.shade200,
       ],
       ),
       ),
      child:Column(
      children: [
        SizedBox(height:290),
        TextField(
          controller: email,
          decoration: InputDecoration(hintText :'Email Here',filled:true,fillColor: Colors.white),
        ),
        
        ElevatedButton(onPressed: (()=>reset()), child: Text('Send Reset Link'))
      ]


     ),),
     
    );
}}