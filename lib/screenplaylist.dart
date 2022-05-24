import 'package:expresso/playlist_hindi.dart';
import 'package:expresso/playlist_lists.dart';
import 'package:expresso/screensettings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: SettingsScreen(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Playlists",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800), 
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.playlist_add),
          ),
        ],
      ),

    body: ListView( 
      children: const [
                    Playlist(playlistname: "Hindi Songs", numsongs: "10 Songs", gopage: HindiPlaylist()),
                    Playlist(playlistname: "Tamil Songs", numsongs: "5 Songs", gopage: HindiPlaylist()),
                    Playlist(playlistname: "Night Songs", numsongs: "9 Songs", gopage: HindiPlaylist()),
                    Playlist(playlistname: "EM!NEM", numsongs: "2 Songs", gopage: HindiPlaylist()),
      ],
    ),
      
    );
  }
}