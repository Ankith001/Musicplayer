import 'package:expresso/privacy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  // const SettingsScreen({ Key? key }) : super(key: key);
  // ignore: non_constant_identifier_names
  final Padding = const EdgeInsets.symmetric(horizontal: 20);

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Settings",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [ 
          // ListTile(
          //   title: Text(
          //     'Share App',
          //     style: GoogleFonts.raleway(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white),
          //   ),
          //   trailing: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.share_outlined,
          //         color: Colors.white,
          //         size: 20,
          //       )),
          // ),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>  PolicyDialog(mdFileName: 'privacypolicy.md',),),); 
                },
                icon: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.white,
                  size: 20,
                )),
          ),
          // ListTile(
          //   title: Text(
          //     'Terms and Conditions',
          //     style: GoogleFonts.raleway(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white),
          //   ),
          //   trailing: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.wysiwyg_outlined,
          //         color: Colors.white,
          //         size: 20,
          //       )),
          // ),
          ListTile(
            title: Text(
              'Rate Us',
              style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star_border_outlined,
                  color: Colors.white,
                  size: 20,
                )),
          ),
          ListTile(
            title: Text(
              'About',
              style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LicencePageSimple(),),);
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}



class LicencePageSimple extends StatelessWidget {
  const LicencePageSimple({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const LicensePage(
        applicationName: 'Expresso',
        applicationVersion: '1.0',
      ),
    );
  }
}
