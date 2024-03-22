import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistSong {
  final int? id;
  final String name;
  final String url;

  PlaylistSong({this.id, required this.name, required this.url});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}


class PlaylistManager {
  List<PlaylistSong> _playlist = [];

  List<PlaylistSong> get playlist => _playlist;

  void addSongToPlaylist(PlaylistSong song) {
    _playlist.add(song);
  }



}

class PlaylistDB {
  
}
