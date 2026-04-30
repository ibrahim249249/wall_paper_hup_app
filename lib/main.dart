import 'package:flutter/material.dart';
import 'package:wall_paper_hub_app/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallpaperHub',
      theme: ThemeData(primaryColor: Colors.white),
      home: const Home(),
    );
  }
}

// Please enable Developer Mode in your system settings. Run
//   start ms-settings:developers
// to open settings.
