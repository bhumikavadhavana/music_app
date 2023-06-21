import 'package:audio_player/utils/songs.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/audio.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: mymusiclist
                  .map(
                    (e) => Card(
                      margin: EdgeInsets.only(left: 7, right: 10, top: 10),
                      elevation: 4,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      borderOnForeground: false,
                      child: ListTile(
                        tileColor: Color(0xfffdfdf5),
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            e['image'],
                          ),
                        ),
                        title: Text(
                          e['name'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => musicPage(
                                    music: e['music'],
                                    name: e['name'],
                                    image: e['image']),
                              ),
                            );
                          },
                          child: Icon(Icons.play_circle),
                        ),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

