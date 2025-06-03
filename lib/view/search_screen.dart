import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/controller/api.dart';
import 'package:getx/model/photos_model.dart';
import 'package:getx/widgets/SearchBar.dart';
import 'package:getx/widgets/app_bar.dart';

class SearchScreen extends StatefulWidget {
  String query;
   SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 late List<PhotosModel> searchList ;

  getwallpaper() async {

    searchList = await ApiClient.searchWallpapers(widget.query);
    setState(() {



    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getwallpaper();

  }
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
             MySearchBar(query: '',),
            const SizedBox(height: 16),

            // GridView for wallpapers
            Expanded(

                child: GridView.builder(

                  itemCount: searchList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          searchList[index].src,
                          fit: BoxFit.cover,

                        ),
                      ),
                    );
                  },


                ),

            ),
          ],
        ),
      ),
    );
  }
}
