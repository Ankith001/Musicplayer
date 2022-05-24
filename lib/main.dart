import 'package:expresso/miniplayer.dart';
import 'package:expresso/screenalbum.dart';
import 'package:expresso/screenfavour.dart';
import 'package:expresso/screenhome.dart';
import 'package:expresso/screenplaylist.dart';
import 'package:expresso/screensplash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final lists = [
    const ScreenHome(),
    const FavoriteScreen(),
    const PlaylistScreen(),
    const AlbumScreen(),
  ];
  int seletedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const MiniPlayer(),
      body: lists[seletedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: seletedindex,
        onTap: (value) {
          setState(() {
            seletedindex = value;
          });
        },
        selectedLabelStyle: GoogleFonts.raleway(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.raleway(fontWeight: FontWeight.w500),
        iconSize: 24,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play_outlined),
            label: 'Playlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_outlined),
            label: 'Albums',
          ),
        ],
      ),
    );
  }
}
