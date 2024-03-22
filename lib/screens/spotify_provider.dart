import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projet_spotify_gorouter/models/artistdetails.dart';
import 'package:projet_spotify_gorouter/models/toptrack.dart';
import '../models/album.dart';
import '../models/albumdetails.dart';

class SpotifyProvider {
  
  static const String baseUrl = 'https://api.spotify.com';
  static const String token = 'BQBWGe39jrNur12dUCy4A9hhgsNS3p6ieib2Vf2sUrVdg6EDgdAZQYPSnFzhwHFxdEEfGWYbOoNpHfhTHv7ChTra_09inc4VvGe4Ruxw8xL0Q2RTCHc';

  //requête api avec réponse dans une liste
  static Future<List<Album>> getAlbums() async {
    final String url = '$baseUrl/v1/browse/new-releases';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      final List<dynamic> albumsData = responseData['albums']['items'];
      List<Album> albums = [];
      albumsData.forEach((data){
        albums.add(Album.fromJson(data));
      });
      return albums;
    }
    else{
      throw Exception('Impossible de charger les nouveaux albums');
    }
  }


  static Future<AlbumDetails> getAlbumDetails(String id) async {
    final String url = '$baseUrl/v1/albums/$id';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      return AlbumDetails.fromJson(responseData);
    }
    else{
      throw Exception('impossible de charger les détails');
    }
  }

  static Future<ArtistDetails> getArtistDetails(String id) async {
    final String url = '$baseUrl/v1/artists/$id';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode ==200){
      final responseData = json.decode(response.body);
      return ArtistDetails.fromJson(responseData);
    }
    else{
      throw Exception('impossible de charger les détails');
    }
  }

  static Future<List<TopTrack>> getTopTracks(String artistId) async {
  final String url = '$baseUrl/v1/artists/$artistId/top-tracks';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final List<dynamic> tracksData = responseData['tracks'];
    List<TopTrack> tracks = tracksData.map((track) => TopTrack.fromJson(track)).toList();
    return tracks;
  }
  else{
    throw Exception('Impossible de récupérer les top tracks');
  }
}

 static Future<List<Album>> searchAlbums(String query) async {
    final String url = '$baseUrl/v1/search?type=album&market=FR&q=$query';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> albumsData = responseData['albums']['items'];
      List<Album> albums = albumsData.map((data) => Album.fromJson(data)).toList();
      return albums;
    } else {
      throw Exception('Impossible de charger les albums');
    }
  }

  static Future<List<ArtistDetails>> searchArtists(String query) async {
    final String url = '$baseUrl/v1/search?type=artist&market=FR&q=$query';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> artistsData = responseData['artists']['items'];
      List<ArtistDetails> artists = artistsData.map((data) => ArtistDetails.fromJson(data)).toList();
      return artists;
    } else {
      throw Exception('Impossible de charger les albums');
    }
  }
  
}