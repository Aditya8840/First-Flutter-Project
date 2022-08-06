import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(FirebaseAuth.instance.currentUser!.email.toString(), textAlign: TextAlign.center, style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),),
            ),
            InkWell(
              onTap: () {
                //Logout
                signOut();

              },
              child: Container(
                height: 60,
                width: 180,
                // padding: EdgeInsets.all(20),
                child: Card(
                    elevation: 10,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20)),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Logout", style: TextStyle(
                          color: Colors.white, fontSize: 25),),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), maintainState: true),
            (Route<dynamic> route) => false);
  }

}