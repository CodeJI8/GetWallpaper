import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/controller/api.dart';
import 'package:getx/model/photos_model.dart';
import 'package:getx/widgets/SearchBar.dart';
import 'package:getx/widgets/app_bar.dart';
import 'package:getx/widgets/cat_block.dart';

class HomeScreen extends StatefulWidget {
  final String src;
  HomeScreen({super.key, required this.src});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingList = [];

  bool isLoading = true;

  void getTrendingWallpaper() async {
    try {
      print("[DEBUG] Fetching trending wallpapers...");
      List<PhotosModel> wallpapers = await ApiClient.getTrendingWallpapers();
      print("[DEBUG] Wallpapers fetched: ${wallpapers.length}");
      setState(() {
        trendingList = wallpapers;
        isLoading = false;
      });
    } catch (e) {
      print("[ERROR] Failed to fetch wallpapers: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading spinner while fetching data
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (trendingList.isEmpty) {
      // Show message if no wallpapers found
      return Scaffold(
        appBar: AppBar(
          title: Myappbar(word1: "Wallpaper", word2: "Jit"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("No wallpapers found."),
        ),
      );
    }

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
            MySearchBar(query: ''),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingList.length,
                itemBuilder: (context, index) {
                  final photo = trendingList[index];
                  return CatBlock(
                    imgSrc: photo.src,

                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: trendingList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final photo = trendingList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(photo.src),
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
