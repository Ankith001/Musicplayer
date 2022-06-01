import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expresso/main.dart';
import 'package:expresso/screenhome.dart';
import 'package:expresso/screenplaying.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

// ignore: must_be_immutable
class PlaylistList extends StatefulWidget {
  String name;

  int playlistkey;

  PlaylistList({Key? key, required this.name, required this.playlistkey})
      : super(key: key);

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.name,
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<SongEntity>>(
          future: OnAudioRoom().queryAllFromPlaylist(widget.playlistkey),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return Text(
                "No Songs found!",
                style: GoogleFonts.raleway(color: Colors.white),
              );
            }
            List<SongEntity> playlistsongs = item.data!;

            List<Audio> playlistm = [];

            for (var songs in playlistsongs) {
              playlistm.add(
                Audio.file(
                  songs.lastData,
                  metas: Metas(
                    title: songs.title,
                    artist: songs.artist,
                    id: songs.id.toString(),
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(255, 20, 40, 21), Colors.black],
                      ),
                    ),
                    child: ListTile(
                      
                      onLongPress: () async {
                        await audioRoom.deleteFrom(
                            RoomType.PLAYLIST, playlistsongs[index].id,
                            playlistKey: widget.playlistkey);
                        setState(() {});
                        // Navigator.pop(context, 'OK');
                      },
                      onTap: () async {
                        await player.open(
                            Playlist(audios: playlistm, startIndex: index),
                            showNotification: true,
                            loopMode: LoopMode.playlist,
                            notificationSettings:
                                const NotificationSettings(stopEnabled: false));
                      },
                      leading: CircleAvatar(
                        child: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(300),
                              ),
                              child: Image.asset('assets/Images/apple.jpg')),
                        ),
                      ),
                      title: Text(
                        item.data![index].title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
