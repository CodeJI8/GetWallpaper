import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/widgets/SearchBar.dart';
import 'package:getx/widgets/app_bar.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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

Stack(
  children: [
    Image.network(
        height: 150,
        width: MediaQuery.of(context).size.width,
        fit:  BoxFit.cover,
        "https://c4.wallpaperflare.com/wallpaper/531/951/621/digital-digital-art-artwork-illustration-minimalism-hd-wallpaper-preview.jpg"

    ),
    Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      color: Colors.black38,
    ),
    SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8), // spacing between texts
            Text(
              "Mountain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),


  ],
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
