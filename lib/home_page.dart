

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user=FirebaseAuth.instance.currentUser;
   


  signOut() async{
    await FirebaseAuth.instance.signOut();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title :Text("Homepage"),),
     body:Center(
      child:Text('${user!.email}'),
     ),
     floatingActionButton: FloatingActionButton(
      onPressed: (()=>signOut()),
      child: Icon(Icons.login_rounded),
      ),
    );
  }
}