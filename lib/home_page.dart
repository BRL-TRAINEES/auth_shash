

import 'package:firebase_auth/firebase_auth.dart';

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
  Widget build(BuildContext context)

  {
    return Scaffold
      (
      appBar: AppBar(title :Text("Homepage "), backgroundColor: Colors.blueGrey,),
      body:Container(
        decoration: BoxDecoration(   
          gradient: LinearGradient(colors:[
            Colors.blueGrey.shade500,Colors.blueGrey.shade200,
          ],),
        ),
        child:Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text ('                         ${user!.email}                                                                 '),

      SizedBox(height: 20),
      ElevatedButton(
        onPressed: signOut,
        child: Text('Logout'),
      ),
      ],
    ),
    )
    );
  }
}