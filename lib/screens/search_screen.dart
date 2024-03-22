import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/models/album.dart';
import 'package:projet_spotify_gorouter/models/artistdetails.dart';
import 'package:projet_spotify_gorouter/screens/spotify_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();
  List<Album> _searchResultsAlbums = [];

  List<ArtistDetails> _searchResultsArtists = [];
  
  bool _searchingForAlbums = true; //etat de recherche

  void _performSearch(String query) {
    if(_searchingForAlbums){
      SpotifyProvider.searchAlbums(query).then((albums) {
        setState(() {
          _searchResultsAlbums = albums;
        });
      }).catchError((error) {
        print('Album non trouvé : $error');
      });
    }
    
    else {
      SpotifyProvider.searchArtists(query).then((artists) {
        setState(() {
          _searchResultsArtists = artists.cast<ArtistDetails>();
        });
      }).catchError((error){
        print('Artiste non trouvé: $error');
      });
    }
  }

  void _navigateToAlbumDetails(String albumId){
    context.go('/a/albumdetails/$albumId');
  }

  void _navigateToArtistDetails(String artistId){

    context.go('/a/artistedetails/$artistId');
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){
                    setState((){
                      _searchingForAlbums = true;
                    });
                  },
                  child: Text('Recherche Albums'),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: (){
                    setState((){
                      _searchingForAlbums = false;
                    });
                  },
                  child: Text('Recherche Artistes'),
                ),
              ],
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: _searchingForAlbums ? 'Recherche album' : 'Recherche artiste',
                suffixIcon: IconButton(
                  onPressed: (){
                    _performSearch(_searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchingForAlbums
                  ? (_searchResultsAlbums.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResultsAlbums.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(_searchResultsAlbums[index].name),
                              subtitle: Text(_searchResultsAlbums[index].id),
                              onTap: () {
                                _navigateToAlbumDetails(_searchResultsAlbums[index].id);
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text('Aucun résultat'),
                        ))
                  : (_searchResultsArtists.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResultsArtists.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchResultsArtists[index].name),
                              subtitle: Text(_searchResultsArtists[index].id),
                              onTap: () {
                                _navigateToArtistDetails(_searchResultsArtists[index].id);
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text('Aucun résultat'),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
