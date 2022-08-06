import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/LoginPage.dart';

import 'HomePage.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  // var name_controller;



  void nav_siginin(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), maintainState: true),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              } else if (snapshot.hasData) {
                return HomePage();
              }
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Sign Up"),
                  ),
                  body: Container(
                    child: SingleChildScrollView( // new line
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 400,
                              child: Image.asset('assets/images/login.jpg'),
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(20),
                            //   child: TextField(
                            //     controller: name_controller,
                            //     decoration: InputDecoration(
                            //       prefixIcon: Icon(Icons.person),
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10)
                            //       ),
                            //       labelText: "Name",
                            //       hintText: "Enter your Name",
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: email_controller,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  labelText: "Email",
                                  hintText: "Enter your email address",
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) => value!=null && !EmailValidator.validate(value)
                                    ?'Enter valid Email':null,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: password_controller,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.key),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                ),
                                obscureText: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) => value!=null && value.length < 8
                                    ?'Enter Strong Password of Minimum length 8':null,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Already User? Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blue),),
                              onTap: () {
                                nav_siginin();
                              },
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                //SignUp
                                signUp();
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
                                      child: Text("Sign Up", style: TextStyle(
                                          color: Colors.white, fontSize: 25),),
                                    )
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  )
              );
            }
        ));
  }

  Future signUp() async{
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim());
    }on FirebaseAuthException catch(e){
      print(e);
    }
  }

}