import 'dart:convert';

import 'package:projet_spotify_gorouter/models/album.dart';

class SearchResult{
  final String href;
  final List<Album> items;

  SearchResult({
    required this.href,
    required this.items,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json){
    return SearchResult(
      href: json['href'] ?? '',
      items: List<Album>.from(json['items'].map((item) => Album.fromJson(item))),
    );
  }
}

// class Album {
//   final String albumType;
//   final List<Artist> artists;
//   final String externalUrl;
//   final String href;
//   final String id;
//   final List<Image> images;
//   final bool isPlayable;
//   final String name;
//   final String releaseDate;
//   final String releaseDatePrecision;
//   final int totalTracks;
//   final String type;
//   final String uri;

//   Album({
//     required this.albumType,
//     required this.artists,
//     required this.externalUrl,
//     required this.href,
//     required this.id,
//     required this.images,
//     required this.isPlayable,
//     required this.name,
//     required this.releaseDate,
//     required this.releaseDatePrecision,
//     required this.totalTracks,
//     required this.type,
//     required this.uri,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       albumType: json['album_type'] ?? '',
//       artists: List<Artist>.from(json['artists'].map((artist) => Artist.fromJson(artist))),
//       externalUrl: json['external_urls']['spotify'] ?? '',
//       href: json['href'] ?? '',
//       id: json['id'] ?? '',
//       images: List<Image>.from(json['images'].map((image) => Image.fromJson(image))),
//       isPlayable: json['is_playable'] ?? false,
//       name: json['name'] ?? '',
//       releaseDate: json['release_date'] ?? '',
//       releaseDatePrecision: json['release_date_precision'] ?? '',
//       totalTracks: json['total_tracks'] ?? 0,
//       type: json['type'] ?? '',
//       uri: json['uri'] ?? '',
//     );
//   }
// }

// class Artist {
//   final String externalUrl;
//   final String href;
//   final String id;
//   final String name;
//   final String type;
//   final String uri;

//   Artist({
//     required this.externalUrl,
//     required this.href,
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.uri,
//   });

//   factory Artist.fromJson(Map<String, dynamic> json) {
//     return Artist(
//       externalUrl: json['external_urls']['spotify'] ?? '',
//       href: json['href'] ?? '',
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       type: json['type'] ?? '',
//       uri: json['uri'] ?? '',
//     );
//   }
// }

// class Image {
//   final int height;
//   final String url;
//   final int width;

//   Image({
//     required this.height,
//     required this.url,
//     required this.width,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) {
//     return Image(
//       height: json['height'] ?? 0,
//       url: json['url'] ?? '',
//       width: json['width'] ?? 0,
//     );
//   }
// }
