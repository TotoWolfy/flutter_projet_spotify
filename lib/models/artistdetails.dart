import 'package:projet_spotify_gorouter/models/albumdetails.dart';

class ArtistDetails{
  final String id;
  final String name;
  final List<String> genres;
  final List<String> images;
  

  ArtistDetails({
    required this.id,
    required this.name,
    required this.genres,
    required this.images,
    
  });

  factory ArtistDetails.fromJson(Map<String, dynamic> json){
    List<String> url = [];
    if (json.containsKey('images')) {
      json['images'].forEach((image) {
        url.add(image['url']);
      });
  }

    

    return ArtistDetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      genres: List<String>.from(json['genres']?? []),
      images: url,
    );
  }
}
