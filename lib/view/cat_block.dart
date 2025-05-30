import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatBlock extends StatelessWidget {
  const CatBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12)
            ,
            child: Image.network(
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
          ),

          Container(
            height: 100,


            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12)
            ),

          ),


          SizedBox(
              height: 100,
              width: 100,

              child: Center(child: Text("Mount" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight:FontWeight.w600) ,)))
        ],
      ),


    );
  }
}
