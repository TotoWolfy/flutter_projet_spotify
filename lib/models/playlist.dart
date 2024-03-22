class PlaylistSong {
  final String name;
  final String url;

  PlaylistSong({required this.name, required this.url});
}


class PlaylistManager {
  List<PlaylistSong> _playlist = [];

  List<PlaylistSong> get playlist => _playlist;

  void addSongToPlaylist(PlaylistSong song) {
    _playlist.add(song);
  }

}
