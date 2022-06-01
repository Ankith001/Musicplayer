import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expresso/screenhome.dart';
import 'package:expresso/screenplaying.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

List<Audio> favSongsList = [];

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Favourites",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog<String>(
              //  barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.black,
                content: Text(
                  'All favorites will be deleted',
                  style: GoogleFonts.dmSans(color: Colors.white),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text('Cancel',
                        style: GoogleFonts.dmSans(color: Colors.green)),
                  ),
                  TextButton(
                    onPressed: () async {
                      await audioRoom.clearRoom(RoomType.FAVORITES);
                      setState(() {});
                      Navigator.pop(context, 'OK');
                    },
                    child: Text('OK',
                        style: GoogleFonts.dmSans(color: Colors.green)),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        //  Add to the future builder the specific type.
        child: FutureBuilder<List<FavoritesEntity>>(
          future: OnAudioRoom().queryFavorites(
            limit: 50,
            reverse: false,
            sortType: null, //  Null will use the [key] has sort.
          ),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return Text(
                "No Favorites found!",
                style: GoogleFonts.raleway(color: Colors.white),
              );
            }

            //=====================>>>>
            List<FavoritesEntity> favorites = item.data!;

            List<Audio> favSongsList = [];

            for (var songs in favorites) {
              favSongsList.add(
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

            //==============>>>>>>>>
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return Container(
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
                    onLongPress: () {
                      showDialog<String>(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.black,
                          content: Text('Remove from Favorites',
                              style: GoogleFonts.dmSans(color: Colors.white)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: Text('Cancel',
                                  style:
                                      GoogleFonts.dmSans(color: Colors.green)),
                            ),
                            TextButton(
                              onPressed: () async {
                                await audioRoom.deleteFrom(
                                  RoomType.FAVORITES,
                                  favorites[index].key,
                                );
                                setState(() {});
                                Navigator.pop(context, 'OK');
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.dmSans(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: CircleAvatar(
                      child: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        // artworkHeight: 50,
                        // artworkWidth: 50,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          child: Image.asset(
                            'assets/Images/apple.jpg',
                            // height: 40,
                            // width: 40, \
                          ),
                        ),
                      ),
                    ),
                    title: Text(favorites[index].title,
                        style: GoogleFonts.dmSans()),
                    onTap: () async {
                      await player.open(
                          Playlist(audios: favSongsList, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
