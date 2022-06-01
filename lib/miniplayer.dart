import 'package:expresso/screenfavour.dart';
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
        return Container(
          height: 65,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.black]),
          ),
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NowPlaying()),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: QueryArtworkWidget(
                id: int.parse(playing.audio.audio.metas.id!),
                type: ArtworkType.AUDIO,
                // ignore: prefer_const_constructors
                nullArtworkWidget: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(300),
                  ),
                  child: Image.asset('assets/Images/apple.jpg'),
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
            trailing: Wrap(
              alignment: WrapAlignment.center,
              children: [
                //  previous
                IconButton(
                  onPressed: playing.index != 0
                      ? () {
                          player.previous();
                        }
                      : () {},
                  icon: playing.index == 0
                      ? const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.black45,
                          size: 43,
                        )
                      : const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                          size: 43,
                        ),
                ),
                // play pause
                PlayerBuilder.isPlaying(
                  player: player,
                  builder: (context, isPlaying) {
                    return IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 43,
                      ),
                      onPressed: () {
                        player.playOrPause();
                      },
                      color: Colors.white,
                    );
                  },
                ),

                // next
                IconButton(
                  iconSize: 43,
                  onPressed: () {
                    player.next();
                  },
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: Colors.white,
                    size: 43,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
