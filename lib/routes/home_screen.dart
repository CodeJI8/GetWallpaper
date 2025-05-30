import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/view/SearchBar.dart';
import 'package:getx/view/app_bar.dart';
import 'package:getx/view/cat_block.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Myappbar(word1: "Wallpaper", word2: "Jit"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MySearchBar(),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: (context, index) => CatBlock(),
              ),
            ),
            const SizedBox(height: 16),
            // GridView for wallpapers
            Expanded(
              
              child: GridView.builder(

                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context,index){

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)
                    ),
                          child: Center(
                            child: Text("Wallpaper ${index + 1}"),
                          ),
                  );
                },

              )
                  
            ),
          ],
        ),
      ),
    );
  }
}
