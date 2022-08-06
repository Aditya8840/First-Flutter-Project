import 'dart:collection';
import 'package:whatsapp/pages/RegisterPage.dart';

import '';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/pages/LoginPage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAD9TcLlhEUVoCd_BzNCWyOkai_whClNro",
        projectId: "todoflutter-6709c",
        messagingSenderId: "401865089169",
        appId: "1:401865089169:web:b57bab26d98d18b930df30",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage('assets/images/login.jpg'), context);
    return MaterialApp(
      title: 'Whatsapp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
      },
    );
  }
}

