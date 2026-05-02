import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  const ImageView({super.key, required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  //final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _save();
                    // Navigator.pop(context);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,

                        decoration: BoxDecoration(
                          color: Color(0xff1C1B1B).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Set Wallpaper',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Image Will be saved in gallery',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await _askPermission();
    final bool hasAccess = await Gal.hasAccess(toAlbum: true);
    if (!hasAccess) {
      await Gal.requestAccess(toAlbum: true);
    }

    var response = await Dio().get(
      widget.imgUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    await Gal.putImageBytes(Uint8List.fromList(response.data));

    Navigator.pop(context);
  }

  Future<void> _askPermission() async {
    if (Platform.isAndroid) {
      await Permission.photos.request();
    } else {
      await Permission.photos.request();
    }
  }

  // _save() async {
  //   if (Platform.isIOS) {
  //     _askPermission();
  //   }
  //   var response = await Dio().get(
  //     widget.imgUrl,
  //     options: Options(responseType: ResponseType.bytes),
  //   );
  //   final result = await ImageGallerySaver.saveImage(
  //     Uint8List.fromList(response.data),
  //   );
  //   print(result);
  //   Navigator.pop(context);
  // }

  // Old API note:
  // `PermissionHandler()` and `PermissionGroup` were removed from newer
  // `permission_handler` versions. Use `Permission.photos.request()` or
  // `[Permission.photos].request()` instead.
}
