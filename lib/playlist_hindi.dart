import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HindiPlaylist extends StatelessWidget {
  const HindiPlaylist({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Hindi Songs",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),

       body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 18, 33, 19), Colors.black]),
        ),
        child: Scrollbar(
          thickness: 3,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 10,
        
            itemBuilder: (context, index) {
              return Column(
                
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/Images/ambarsariya.jpg'),
                    ),
                    title: Text(
                      'Ambarisariya',
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      "Sona Mohapatra",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontWeight: FontWeight.w200),
                    ),

                    //tileColor: Colors.redAccent,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                       
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
      
    );
  }
}