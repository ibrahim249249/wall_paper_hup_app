class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel? src;

  WallpaperModel({
    this.photographer = '',
    this.photographer_url = '',
    this.photographer_id = 0,
    this.src,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData['src']),
      photographer_url: jsonData['photographer_url'],
      photographer_id: jsonData['photographer_id'],
      photographer: jsonData['photographer'],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;
  // late String large2x;
  // late String large;
  // late String medium;
  // late String landscape;
  // late String tiny;
  SrcModel({this.original = '', this.portrait = '', this.small = ''});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData['portrait'],
      original: jsonData['original'],
      small: jsonData['small'],
    );
  }
}
