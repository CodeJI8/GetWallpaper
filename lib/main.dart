import 'package:flutter/material.dart';
import 'package:getx/view/category_screen.dart';
import 'package:getx/view/home_screen.dart';
import 'package:getx/view/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home' : (context) =>HomeScreen(src: '',)
    },
  ));
}


