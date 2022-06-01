import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expresso/openmusic.dart';
import 'package:expresso/screenhome.dart';
import 'package:expresso/screenplaying.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends SearchDelegate {
  List<String> allData = [''];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.grey,
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: const Color.fromARGB(255, 125, 125, 125),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
              border: InputBorder.none,
              fillColor: Color.fromARGB(255, 255, 255, 255)),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: GoogleFonts.raleway(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItem = query.isEmpty
        ? allSongs 
        : allSongs
                .where(
                  (element) => element.title.toLowerCase().contains(   
                        query.toLowerCase().toString(),
                      ),
                )
                .toList() +
            allSongs
                .where(
                  (element) => element.artist!.toLowerCase().contains(
                        query.toLowerCase().toString(),
                      ),
                )
                .toList();
    return Scaffold(
        backgroundColor: Colors.black,
        body: searchSongItem.isEmpty
            ? Center(
                child: Text(
                  "No Songs Found",
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchSongItem.length,
                itemBuilder: (context, index) => Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 18, 33, 19),
                          Colors.black
                        ]),
                  ),
                  child: ListTile(
                    onTap: () async {
                    
                    List<Audio
                    > searchAudio = [];

                    for (var item in allSongs) {
                      searchAudio.add(Audio.file(item.uri!,metas: Metas(
                        id: item.id.toString(),
                        title: item.title,
                        artist: item.artist,
                      )));
                    }



                      await OpenMusic(
                        fullSongs: [],
                        index: index,
                      ).openAssetPlayer(index: index, songs: searchAudio);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const NowPlaying()),
                        ),
                      );
                    },
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: CircleAvatar(
                      child: QueryArtworkWidget(
                        id: searchSongItem[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(300),
                            ),
                            child: Image.asset('assets/Images/apple.jpg')),
                      ),
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(searchSongItem[index].title,
                          style: GoogleFonts.dmSans()),
                    ),
                   
                  ),
                ),
              ));
  }
}
