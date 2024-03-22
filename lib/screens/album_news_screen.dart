import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'spotify_provider.dart';
import '../models/album.dart';

// -- les derniers albums (news)
class AlbumNewsScreen extends StatefulWidget {
  const AlbumNewsScreen({Key? key}) : super(key: key);

  @override
  _AlbumNewsScreenState createState() => _AlbumNewsScreenState();
}

class _AlbumNewsScreenState extends State<AlbumNewsScreen> {
  List<Album> _albums = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      final List<Album> albums = await SpotifyProvider.getAlbums();
      setState(() {
        _albums = albums;
      });
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Les nouveaux albums')),
      body: ListView.builder(
        itemCount: _albums.length,
        itemBuilder: (context, index) {
          return ListTile(
             leading: Image.network(
              _albums[index].images[0],
              width: 50,
              height: 50,
            ),
            title: Text(_albums[index].name),
            // subtitle: Text(_albums[index].href),
            onTap: () => context.go('/a/albumdetails/${_albums[index].id}'),
          );
        },
      ),
    );
  }
}