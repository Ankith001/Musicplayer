import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expresso/playlistclone.dart';
import 'package:expresso/screenplaying.dart';
import 'package:expresso/screensearch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}
//hereeeeeeee====================>>>>>>>>>>>>>

final audioquery = OnAudioQuery();
final OnAudioRoom audioRoom = OnAudioRoom();

//=============================>>>>>>>>>>>>>>>>
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
      //drawer: SettingsScreen(),

//===========AppBar===============//

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Your Library",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(),
              );
            },
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

          return FutureBuilder<List<FavoritesEntity>>(
              future: audioRoom.queryFavorites(
                limit: 50,
                reverse: false,
                sortType: null, //  Null will use the [key] has sort.
              ),
              builder: (context, allFavourite) {
                if (allFavourite.data == null) {
                  return const SizedBox();
                }
                List<FavoritesEntity> favorites = allFavourite.data!;
                List<Audio> favSongs = [];

                for (var fSongs in favorites) {
                  favSongs.add(Audio.file(fSongs.lastData,
                      metas: Metas(
                          title: fSongs.title,
                          artist: fSongs.artist,
                          id: fSongs.id.toString())));
                }

                return ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      bool isFav = false;
                      int? key;
                      for (var fav in favorites) {
                        if (songDetails[index].metas.title == fav.title) {
                          isFav = true;
                          key = fav.key;
                        }
                      }
                      return Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 20, 40, 21),
                              Colors.black
                            ],
                          ),
                        ),
                        child: ListTile(
                          onTap: () async {
                            await player.open(
                                Playlist(
                                    audios: songDetails, startIndex: index),
                                showNotification: true,
                                loopMode: LoopMode.playlist,
                                notificationSettings:
                                    const NotificationSettings(
                                        stopEnabled: false));
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
                                  child:
                                      Image.asset('assets/Images/apple.jpg')),
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
                                onTap: () {
                                  if (!isFav) {
                                     ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          backgroundColor: Colors.green ,
                          content: Text(
                            'Added to Favorites.',
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                        ));
                                    audioRoom.addTo(
                                      RoomType
                                          .FAVORITES, // Specify the room type
                                      allSongs[index]
                                          .getMap
                                          .toFavoritesEntity(),
                                      ignoreDuplicate:
                                          false, // Avoid the same song
                                    );
                                  } else {
                                     ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Removed from Favorites. ', 
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                        ));
                                    audioRoom.deleteFrom(
                                        RoomType.FAVORITES, key!);
                                  }
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: isFav ? Colors.red : Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog<String>(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text('Add to Playlist?',
                                          style: GoogleFonts.dmSans(
                                              color: Colors.black)),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'No'),
                                          child: Text('No',
                                              style: GoogleFonts.dmSans(
                                                color: Colors.green,
                                              )),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context, 'Yes'); 
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       PlaylistClone(songindex: index,)),
                                            );
                                            setState(() {});
                                            
                                          },
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.dmSans(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Icon(Icons.more_vert_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
        },
      ),
    );
  }
} 


