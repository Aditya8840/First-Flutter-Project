import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/ForgetPassword.dart';
import 'package:whatsapp/pages/HomePage.dart';
import 'package:whatsapp/pages/RegisterPage.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void dispose(){
    email_controller.dispose();
    password_controller.dispose();

    super.dispose();
  }

  void nav_home(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(), maintainState: true),
            (Route<dynamic> route) => false);
  }

  void nav_siginup(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(), maintainState: true),
            (Route<dynamic> route) => false);
  }

  void nav_forgot(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPage()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
              body: Container(
            child: SingleChildScrollView(    // new line
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 400,
                      child: Image.asset('assets/images/login.jpg'),
                    ),
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
                            ?'Enter a valid Email':null,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: TextField(
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
                      ),
                    ),
                    InkWell(
                      child: Text("Forgot Password", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue),),
                      onTap: () {
                        //forgot password
                        nav_forgot();
                      },
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      child: Text("New User? Register", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue),),
                      onTap: () {
                        nav_siginup();
                      },
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        //Login
                        signIn();
                      },
                      child : Container(
                        height: 60,
                        width: 180,
                        // padding: EdgeInsets.all(20),
                        child: Card(
                            elevation: 10,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 25),),
                            )
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ));

        }
      )

    );
  }

  Future signIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim()
      );
    } on FirebaseAuthException catch(e){
      print(e);
    }
  }
  
}