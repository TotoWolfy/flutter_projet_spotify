import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/models/artistdetails.dart';
import 'package:projet_spotify_gorouter/models/toptrack.dart';
import 'package:projet_spotify_gorouter/screens/spotify_provider.dart';

class ArtisteDetailScreen extends StatefulWidget {
  final String id;
  const ArtisteDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ArtisteDetailScreenState createState() => _ArtisteDetailScreenState();
}

class _ArtisteDetailScreenState extends State<ArtisteDetailScreen> {
  late Future<ArtistDetails> _artistDetailsFuture;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _artistDetailsFuture = SpotifyProvider.getArtistDetails(widget.id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails Artiste')),
      body: FutureBuilder<ArtistDetails>(
        future: _artistDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final artistDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      artistDetails.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      artistDetails.images.first,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  FutureBuilder<List<TopTrack>>(
                    future: SpotifyProvider.getTopTracks(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erreur: ${snapshot.error}');
                      } else {
                        final topTracks = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'les plus populaires',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: topTracks.length,
                              itemBuilder: (context, index) {
                                final track = topTracks[index];
                                return ListTile(
                                  title: Text(track.name),
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
                                            await _playAudio(track.url);
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
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
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