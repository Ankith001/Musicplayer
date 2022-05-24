import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expresso/screenplaying.dart';
import 'package:expresso/screensettings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

final audioquery = OnAudioQuery();
List<SongModel> allSongs = [];
List<Audio> songDetails = [];

class _ScreenHomeState extends State<ScreenHome> {

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    Permission.storage.request();
    allSongs = await audioquery.querySongs();
    for (var i in allSongs) {
      songDetails.add(Audio.file(i.uri.toString(),
          metas: Metas(
              title: i.title,
              artist: i.artist,
              id: i.id.toString(),
              album: i.album)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        drawer: SettingsScreen(),

//===========AppBar===============//

        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            "Your Library", 
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
            future: audioquery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Songs to Display',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: item.data!.length,
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
                      await player.open(
                          Playlist(audios: songDetails, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                    textColor: Colors.white,
                    iconColor: Colors.white,
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
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(item.data![index].displayNameWOExt,
                          style: GoogleFonts.dmSans()),
                    ),
                    trailing: Wrap(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.favorite_border_outlined,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.more_vert_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // body: Container(
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [Color.fromARGB(255, 18, 33, 19), Colors.black]),
            //   ),
            //   child: Scrollbar(

            //     thickness: 3,
            //     child: ListView.builder(
            //       // shrinkWrap: true,
            //       // physics: const ClampingScrollPhysics(),
            //       itemCount: player.playlist!.audios.length,
            //       itemBuilder: (context, int index) {
            //         return Container(
            //           child: listItems(
            //             onTap: () {
            //               songsLibrary(index, player.playlist!.audios);
            //             },
            //             title: player.playlist!.audios[index].metas.title,
            //             artist: player.playlist!.audios[index].metas.artist,
            //             albumimage: player.playlist!.audios[index].metas.image!.path,
            //           ),
            //         );
            //       },
            //     ),
            //   ),

            // ),
            ));
  }
}

void songsLibrary(int index, List<Audio> audios) async {
  await player.open(
    Playlist(
      audios: audios,
      startIndex: index,
    ),
    showNotification: true,
    notificationSettings: const NotificationSettings(
      stopEnabled: false,
    ),
    playInBackground: PlayInBackground.enabled,
  );
}
