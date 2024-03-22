class AlbumDetails {
  String title;
  List<String> images;
  List<String> artists;
  List<SongDetails> songs;
  final String id;
  final String artistId;

  AlbumDetails({
    required this.title,
    required this.images,
    required this.artists,
    required this.songs,
    required this.id,
    required this.artistId,
  });

  factory AlbumDetails.fromJson(Map<String, dynamic> json) {
    List<String> artistNames = [];
    List<String> artistIds = [];
    if (json.containsKey('artists')) {
      var artists = json['artists'];
      if (artists != null && artists is List) {
        for (var artist in artists) {
          artistNames.add(artist['name']);
          artistIds.add(artist['id']);
        }
      }
    }

    List<String> url = [];
    if (json.containsKey('images')) {
      json['images'].forEach((image) {
        url.add(image['url']);
      });
    }

    List<SongDetails> songs = [];
    if (json.containsKey('tracks')) {
      var tracksData = json['tracks'];
      if (tracksData != null && tracksData['items'] is List) {
        for (var song in tracksData['items']) {
          songs.add(SongDetails.fromJson(song));
        }
      }
    }

    final title = json['name'] ?? '';

    return AlbumDetails(
      title: title,
      images: url,
      artists: artistNames,
      songs: songs,
      id: json['id'] ?? '',
      artistId: artistIds.isNotEmpty ? artistIds.first : '',
    );
  }
}


class SongDetails {
  String name;
  String previewUrl;

  SongDetails({
    required this.name,
    required this.previewUrl,
  });

  factory SongDetails.fromJson(Map<String, dynamic> json) {
    return SongDetails(
      name: json['name'] ?? '',
      previewUrl: json['preview_url'] ?? '',
    );
  }
}
