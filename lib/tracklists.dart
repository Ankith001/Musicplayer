import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listItems({
  required title,
  required artist,
  required albumimage,
  required onTap,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap, 
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            child: Image.asset(albumimage),
          ),
          title: Text(
            title,
            style: GoogleFonts.raleway(
                color: Colors.white, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            artist,
            style: GoogleFonts.raleway(
                color: Colors.white, fontWeight: FontWeight.w200),
          ),
          
          trailing: Row(
            
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
             
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
