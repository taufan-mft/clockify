import 'package:clockify/constants.dart';
import 'package:clockify/models/saved.dart';
import 'package:clockify/provider/ActivityState.dart';
import 'package:clockify/providers/allSaved.dart';
import 'package:clockify/screens/SignIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          lazy: false,
          create: (context) => ActivityState(),
          child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clockify',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
      ),
      home:  signIn(),
    );
  }
}

