import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wall_paper_hub_app/data/data.dart';
import 'package:wall_paper_hub_app/model/categories_model.dart';
import 'package:wall_paper_hub_app/model/wallpaper_model.dart';
import 'package:wall_paper_hub_app/views/categorie.dart';
import 'package:wall_paper_hub_app/views/search.dart';
import 'package:wall_paper_hub_app/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  final TextEditingController searchController = TextEditingController();

  Future<void> getTrendingWallpapers() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=30&page=1"),
      headers: {'Authorization': apiKey},
    );
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final photos = jsonData['photos'] as List<dynamic>? ?? [];
    final fetchedWallpapers = photos
        .map((element) => WallpaperModel.fromMap(element as Map<String, dynamic>))
        .toList();
    if (!mounted) return;
    setState(() {
      wallpapers = fetchedWallpapers;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getTrendingWallpapers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: brandName(), elevation: 0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'search wallpaper',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Search(searchgQuery: searchController.text),
                        ),
                      );
                    },
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].catrgorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
                ),
              ),
            ),
            wallpapersList(wallpapers, context),
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoriesTile({super.key, required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categorie(categorieName: title.toLowerCase()),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
