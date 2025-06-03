// lib/api/api_client.dart
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import '../model/categoryModel.dart';
import '../model/photos_model.dart';


class ApiClient {
  static const String _baseUrl = "https://api.pexels.com/v1";
  static const String _apiKey = "ADROWw7lJsQljdgJFjA7Bi9Dmvc5pkLCmegvJdkGMfMvCN7xLGSrj1gp";

  static Future<List<PhotosModel>> fetchWallpapers(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/$endpoint"),
        headers: {
          "Authorization": _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> photos = jsonData['photos'];
        return photos.map((e) => PhotosModel.fromApi2App(e)).toList();
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }
  }

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    return await fetchWallpapers("curated");
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    return await fetchWallpapers("search?query=$query&per_page=30&page=1");
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List<String> categoryNames = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];

    List<CategoryModel> categoryList = [];
    final random = Random();

    for (String cat in categoryNames) {
      final photos = await searchWallpapers(cat);
      if (photos.isNotEmpty) {
        final photo = photos[random.nextInt(photos.length)];
        categoryList.add(CategoryModel(catName: cat, catImgUrl: photo.src));
      }
    }

    return categoryList;
  }
}
