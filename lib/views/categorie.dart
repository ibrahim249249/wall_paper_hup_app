import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wall_paper_hub_app/data/data.dart';
import 'package:wall_paper_hub_app/model/wallpaper_model.dart';
import 'package:wall_paper_hub_app/widgets/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  const Categorie({super.key, required this.categorieName});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = [];

  Future<void> getSearchWallpapers(String query) async {
    final response = await http.get(
      Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
      ),
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
    getSearchWallpapers(widget.categorieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: brandName(), elevation: 0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            wallpapersList(wallpapers, context),
          ],
        ),
      ),
    );
  }
}
