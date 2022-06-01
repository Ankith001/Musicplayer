import 'package:expresso/playlistlist.dart';
import 'package:expresso/screenhome.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  TextEditingController playlistcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.black,
        // drawer: SettingsScreen(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            "Playlists",
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
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
                            if (value == null || value.isEmpty || value == "") {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistList(
                              name: item.data![index].playlistName,
                              playlistkey: playList[index].key),
                        ),
                      );
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
                      style: GoogleFonts.dmSans(),
                    ),
                    leading: const Icon(Icons.queue_music, color: Colors.white),
                    subtitle: Text(
                      item.data![index].playlistSongs.length.toString() +
                          " Songs",
                      style: GoogleFonts.dmSans(color: Colors.grey),
                      
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
