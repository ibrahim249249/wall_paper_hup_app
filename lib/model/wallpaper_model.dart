class WallpaperModel {
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final SrcModel? src;

  WallpaperModel({
    this.photographer = '',
    this.photographerUrl = '',
    this.photographerId = 0,
    this.src,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: jsonData['src'] == null
          ? null
          : SrcModel.fromMap(jsonData['src'] as Map<String, dynamic>),
      photographerUrl: jsonData['photographer_url'] as String? ?? '',
      photographerId: (jsonData['photographer_id'] as num?)?.toInt() ?? 0,
      photographer: jsonData['photographer'] as String? ?? '',
    );
  }
}

class SrcModel {
  final String original;
  final String small;
  final String portrait;
  // late String large2x;
  // late String large;
  // late String medium;
  // late String landscape;
  // late String tiny;
  SrcModel({this.original = '', this.portrait = '', this.small = ''});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData['portrait'] as String? ?? '',
      original: jsonData['original'] as String? ?? '',
      small: jsonData['small'] as String? ?? '',
    );
  }
}
