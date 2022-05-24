import 'package:expresso/playlist_hindi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Playlist extends StatelessWidget {
  const Playlist({
    Key? key,
    required this.playlistname,
    required this.numsongs,
     this.gopage,
  }) : super(key: key);

  final String playlistname;
  final String numsongs;
  final gopage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 18, 33, 19), Colors.black]),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext) => gopage),
          );
        },
        title: Text(
          playlistname,
          style: GoogleFonts.raleway(
              color: Colors.white, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          numsongs,
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.w300),
        ),

        //tileColor: Colors.redAccent,
        trailing: const Icon(
          Icons.more_horiz,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
