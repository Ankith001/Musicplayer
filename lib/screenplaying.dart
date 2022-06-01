

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:expresso/screenhome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';


class NowPlaying extends StatefulWidget {
  const NowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}



AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

class _NowPlayingState extends State<NowPlaying>
    with SingleTickerProviderStateMixin {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            "Now Playing",
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
          ),
        ),
        body:
            
            player.builderCurrent(
          builder: (context, playing) {
            

            return Builder(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                        height: 300,
                        width: 300,
                        child: QueryArtworkWidget(
                          artworkQuality: FilterQuality.high,
                          id: int.parse(playing.audio.audio.metas.id!),
                          type: ArtworkType.AUDIO,
                          // ignore: prefer_const_constructors
                          nullArtworkWidget: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                              child: Image.asset('assets/Images/apple.jpg')),
                        )),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    player.getCurrentAudioTitle,
                    style: GoogleFonts.josefinSans(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    player.getCurrentAudioArtist,
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        seekBarWidget(context),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             
                              IconButton(
                                iconSize: 45,
                                onPressed: playing.index != 0
                                    ? () {
                                        player.previous();
                                      }
                                    : () {},
                                icon: playing.index == 0
                                    ? const Icon(
                                        Icons.skip_previous_rounded,
                                        color:
                                            Color.fromARGB(81, 255, 255, 255),
                                        size: 60,
                                      )
                                    : const Icon(
                                        Icons.skip_previous,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 60,
                                      ),
                              ),
                              const SizedBox(width: 20),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      player.playOrPause();
                                    },
                                    color: Colors.white,
                                  );
                                },
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                iconSize: 45,
                                onPressed: playing.index == allSongs.length - 1
                                    ? () {}
                                    : () {
                                        player.next();
                                      },
                                icon: playing.index == allSongs.length - 1
                                    ? const Icon(
                                        Icons.skip_next,
                                        color:
                                            Color.fromARGB(81, 255, 255, 255),
                                        size: 60,
                                      )
                                    : const Icon(
                                        Icons.skip_next,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 60,
                                      ),
                              ),
                              const SizedBox(width: 20),
                            
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              );
            });
          },
        ));
  }
}

Widget seekBarWidget(BuildContext ctx) {
  return player.builderRealtimePlayingInfos(builder: (ctx, infos) {
    Duration currentPosition = infos.currentPosition;
    Duration total = infos.duration;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ProgressBar(
        progress: currentPosition,
        total: total,
        onSeek: (to) {
          player.seek(to);
        },
        timeLabelTextStyle: const TextStyle(color: Colors.white),
        baseBarColor: const Color.fromARGB(255, 190, 190, 190),
        progressBarColor: const Color(0xFF32C437),
        bufferedBarColor: const Color(0xFF32C437),
        thumbColor: const Color(0xFF32C437),
      ),
    );
  });
}
