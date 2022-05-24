import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  // const SettingsScreen({ Key? key }) : super(key: key);
  final Padding = EdgeInsets.symmetric(horizontal: 20);

  @override 
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SettingHeader(context),
            SettingMenu(context),
          ],
        ),
      ),
    );
  }

  Widget SettingHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget SettingMenu(BuildContext context) => Column(
        children: [
          ListTile(
            //leading: Icon(Icons.settings_outlined,color: Colors.white,),
            title: Text(
              'Settings',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)
              ),
            ),
            
          ),

          Divider(
            thickness: 2,
          //  color: Color.fromARGB(255, 0, 0, 0),
          ),

//=========List=====//

          ListTile(
          
            title: Text(
              'Share App',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
            trailing: Icon(Icons.share_outlined,color: Color.fromARGB(255, 255, 255, 255),size: 20),
          ),
          ListTile(
            
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                 color: Colors.white
              ),
            ),
            trailing: Icon(Icons.privacy_tip_outlined,color: Colors.white,size: 20),
          ),
          ListTile(
           
            title: Text(
              'Terms and Conditions',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                 color: Colors.white
              ),
            ),
             trailing: Icon(Icons.wysiwyg,color: Colors.white,size: 20),
          ),

           ListTile( 
            title: Text(
              'Rate Us',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                 color: Colors.white
              ),
            ),
             trailing: Icon(Icons.star_border_outlined,color: Colors.white,size: 20),
          ),

          ListTile( 
            title: Text(
              'About',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                 color: Colors.white
              ),
            ),
             trailing: Icon(Icons.info_outline_rounded,color: Colors.white,size: 20),
          ),
        
         
        ],
      );
}
