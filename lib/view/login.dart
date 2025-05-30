import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _LoginState();
}

class _LoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
         decoration: BoxDecoration(
           color: Colors.white,
           image: DecorationImage(image: AssetImage('assets/ic_name.png'))
         ),
    );
  }
}
