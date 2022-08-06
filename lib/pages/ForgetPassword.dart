import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/HomePage.dart';
import 'package:whatsapp/pages/RegisterPage.dart';

class ForgetPage extends StatefulWidget{
  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Work in progress", style: TextStyle(
          color: Colors.blue,
          fontSize: 25,
          fontWeight: FontWeight.w300,
        ),
        ),
      ),
    );
  }

}