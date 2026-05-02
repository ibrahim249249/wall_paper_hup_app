import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wall_paper_hub_app/data/data.dart';
import 'package:wall_paper_hub_app/model/wallpaper_model.dart';
import 'package:wall_paper_hub_app/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchgQuery;
  const Search({super.key, required this.searchgQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
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
    searchController.text = widget.searchgQuery;
    getSearchWallpapers(widget.searchgQuery);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: brandName(), elevation: 0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
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
                      getSearchWallpapers(searchController.text);
                    },
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            wallpapersList(wallpapers, context),
          ],
        ),
      ),
    );
  }
}
