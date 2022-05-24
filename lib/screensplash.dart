import 'dart:async';
import 'package:expresso/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    blinko();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 38, 76, 41), Colors.black]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.music,
                size: 50,
                color:Color.fromARGB(255, 58, 136, 64)
              ),
             

              Text(
                "Expresso",
                style: GoogleFonts.cookie(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ));
  }

  Future<void> blinko() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) {
        return const Home();
      }),
    );
  }
}


// Scaffold(
//       backgroundColor: Color.fromARGB(255, 25, 21, 9),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/Images/Splash.png',
//               fit: BoxFit.fitHeight,
//               cacheHeight: 200,
//               cacheWidth: 200,
//             ),
//           ],
//         ),
//       ),
//     );
