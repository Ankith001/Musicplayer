
import 'package:expresso/screenhome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_room/on_audio_room.dart';

// ignore: must_be_immutable
class PlaylistClone extends StatefulWidget {
  int songindex;

  PlaylistClone({Key? key, required this.songindex}) : super(key: key);

  @override
  State<PlaylistClone> createState() => _PlaylistCloneState();
}

class _PlaylistCloneState extends State<PlaylistClone> {
  TextEditingController playlistcontroller = TextEditingController();

  OnAudioRoom audioRoom = OnAudioRoom();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // drawer: SettingsScreen(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            "Add to Playlist",
            style:
                GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog<String>(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Create new Playlist',
                        style: GoogleFonts.dmSans(color: Colors.black)),
                    actions: <Widget>[
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: playlistcontroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter playlist name',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            audioRoom.createPlaylist(playlistcontroller.text);
                            playlistcontroller.clear();
                            Navigator.pop(context, 'Create');
                            setState(() {});
                          }
                          //
                        },
                        child: Text(
                          'Create',
                          style: GoogleFonts.dmSans(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.playlist_add),
            ),
          ],
        ),
        body: FutureBuilder<List<PlaylistEntity>>(
          future: audioRoom.queryPlaylists(),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Playlists Found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            List<PlaylistEntity> playList = item.data!;
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
                    onTap: () {
                      audioRoom.addTo(RoomType.PLAYLIST,
                          allSongs[widget.songindex].getMap.toSongEntity(),
                          playlistKey: playList[index].key,
                          ignoreDuplicate: false);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Song Added to Playlist',
                            style: GoogleFonts.dmSans(color: Colors.white),
                          ),
                        ));
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Delete Playlist?',
                                  style:
                                      GoogleFonts.dmSans(color: Colors.black),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Yes',
                                        style: GoogleFonts.dmSans(
                                          color: Colors.green,
                                        )),
                                    onPressed: () {
                                      audioRoom.deletePlaylist(
                                          item.data![index].key);
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child: Text('No',
                                        style: GoogleFonts.dmSans(
                                          color: Colors.green,
                                        )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                    textColor: Colors.white,
                    title: Text(
                      item.data![index].playlistName,
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
