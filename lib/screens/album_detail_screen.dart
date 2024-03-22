import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:projet_spotify_gorouter/screens/spotify_provider.dart';

import '../models/albumdetails.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  /// Constructs a [AlbumDetailScreen]
  final String id;
  const AlbumDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Future<AlbumDetails> _albumDetailsFuture;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _albumDetailsFuture = SpotifyProvider.getAlbumDetails(widget.id);
    _audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }




//id:widget:id
// -- detail d'un album
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails album')),
      body: FutureBuilder<AlbumDetails>(
        future: _albumDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final albumDetails = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  albumDetails.images.first,
                  width: 300,
                  height: 300,
                ),
                Text(albumDetails.title, style: TextStyle(fontSize: 24)),
                GestureDetector(
                  onTap: () {
                    context.go('/a/artistedetails/${albumDetails.artistId}');
                  },
                  child: Text(
                    'Artiste:${albumDetails.artists.join(" ")}',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Chansons de l'album:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: albumDetails.songs.length,
                    itemBuilder: (context, index) {
                      final song = albumDetails.songs[index];
                      return ListTile(
                        title: Text(song.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                              onPressed: () async {
                                setState(() {
                                  _isPlaying = !_isPlaying; 
                                });
                                if (_isPlaying) {
                                  await _playAudio(song.previewUrl);
                                } else {
                                  await _stopAudio();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _playAudio(String url) async {
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }
}