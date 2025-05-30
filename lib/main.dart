import 'package:flutter/material.dart';
import 'package:getx/routes/home_screen.dart';
import 'package:getx/view/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home' : (context) =>HomeScreen()
    },
  ));
}


