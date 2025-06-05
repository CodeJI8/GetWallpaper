import 'package:flutter/material.dart';
import 'package:getx/controller/api.dart';
import 'package:getx/model/photos_model.dart';
import 'package:getx/view/full_screen.dart';
import 'package:getx/widgets/SearchBar.dart';
import 'package:getx/widgets/app_bar.dart';
import 'package:getx/widgets/cat_block.dart';

import '../model/categoryModel.dart';

class HomeScreen extends StatefulWidget {
  final String src;
  const HomeScreen({super.key, required this.src});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingList = [];
  List<CategoryModel> categoryList = [];
  bool isLoading = true;

  void getTrendingWallpaper() async {
    try {
      List<PhotosModel> wallpapers = await ApiClient.getTrendingWallpapers();
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

  void getCategoryList() async {
    try {
      List<CategoryModel> cats = await ApiClient.getCategoriesList();
      setState(() {
        categoryList = cats;
      });
    } catch (e) {
      print("[ERROR] Failed to fetch categories: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getTrendingWallpaper();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Myappbar(word1: "Wallpaper", word2: "Jit"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySearchBar(query: ''),
              const SizedBox(height: 16),

              // Category List
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final cat = categoryList[index];
                    return CatBlock(
                      imgSrc: cat.catImgUrl,
                      categoryName: cat.catName,
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Wallpapers Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: trendingList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final photo = trendingList[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context ,MaterialPageRoute(builder: (context)=> FullScreen(imgUrl:  trendingList[index].src)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(photo.src),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
