import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myappbar extends StatelessWidget {

  final String word1;
  final String word2;

  const Myappbar({super.key,
  required this.word1,
  required this.word2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: RichText( textAlign: TextAlign.center , text: TextSpan(
        children:[
TextSpan(text: word1 , style: TextStyle(color: Colors.black, fontSize: 30, fontWeight:FontWeight.w600
)
    ,children: [


      TextSpan(text: " $word2", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight:FontWeight.w600))


    ]



),
]
      )),
      
    );
  }
}
