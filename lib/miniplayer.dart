import 'package:expresso/screenhome.dart';
import 'package:expresso/screenplaying.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
      builder: (context, playing) {
        final myAudio = find(songDetails, playing.audio.assetAudioPath);
        return Container(
          height: 65, 
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 29, 99, 33),
                  Color.fromARGB(255, 29, 99, 33)
                ]),
          ),
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NowPlaying()),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: QueryArtworkWidget(
                id: int.parse(myAudio.metas.id.toString()),
                type: ArtworkType.AUDIO,
                // ignore: prefer_const_constructors
                nullArtworkWidget: Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                player.getCurrentAudioTitle,
                style: GoogleFonts.josefinSans(
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                player.getCurrentAudioArtist,
                style: GoogleFonts.josefinSans(color: Colors.grey),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PlayerBuilder.isPlaying(
                player: player,
                builder: (context, isPlaying) {
                  return IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle_fill_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      player.playOrPause();
                    },
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
