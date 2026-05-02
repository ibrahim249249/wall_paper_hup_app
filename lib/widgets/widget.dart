import 'package:flutter/material.dart';
import 'package:wall_paper_hub_app/model/wallpaper_model.dart';
import 'package:wall_paper_hub_app/views/image_view.dart';

Widget brandName() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: 'Wallpaper',
            style: TextStyle(color: Colors.black87),
          ),
          TextSpan(
            text: 'Hub',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, BuildContext context) {
  final validWallpapers = wallpapers
      .where((wallpaper) => wallpaper.src != null && wallpaper.src!.portrait.isNotEmpty)
      .toList();
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: validWallpapers.map((wallpaper) {
        final portrait = wallpaper.src!.portrait;
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageView(imgUrl: portrait)),
              );
            },
            child: Hero(
              tag: portrait,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
