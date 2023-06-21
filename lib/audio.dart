import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/utils/songs.dart';
import 'package:flutter/material.dart';

class musicPage extends StatefulWidget {
  String music;
  String name;
  String image;

  musicPage(
      {Key? key, required this.music, required this.name, required this.image})
      : super(key: key);

  @override
  State<musicPage> createState() => _musicPageState();
}

class _musicPageState extends State<musicPage> with TickerProviderStateMixin {
  AssetsAudioPlayer myaudio = AssetsAudioPlayer();

  Duration? totalDuration;
  Duration max = Duration.zero;

  @override
  void initState() {
    super.initState();
    myaudio
        .open(
          Playlist(
            audios: mymusiclist.map((e) => Audio(widget.music)).toList(),
          ),
          autoStart: true,
        )
        .then((_) => setState(() {
              max = myaudio.current.value!.audio.duration;
            }));
  }

  @override
  void dispose() {
    super.dispose();
    myaudio.dispose();
  }

  bool play = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xffffffff),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              //
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 140,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/originals/22/e1/4f/22e14f4d73e7b2d3fd22ae80304e85c4.gif"),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(widget.image),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff),
                  fontSize: 22,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      await myaudio.stop();
                    },
                    icon: Icon(
                      Icons.stop,
                      color: Color(0xffffffff),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await myaudio.seekBy(Duration(seconds: -10));
                    },
                    icon: Icon(
                      Icons.fast_rewind_sharp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  StreamBuilder(
                    stream: myaudio.isPlaying,
                    builder: (context, snapshot) {
                      var val = snapshot.data;

                      return IconButton(
                        onPressed: () async {
                          (val == true) ? myaudio.pause() : myaudio.play();
                        },
                        icon: (val == true)
                            ? Icon(
                                Icons.pause,
                                color: Color(0xffffffff),
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Color(0xffffffff),
                              ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      await myaudio.seekBy(
                        Duration(seconds: 10),
                      );
                    },
                    icon: Icon(
                      Icons.fast_forward_rounded,
                      color: Color(0xffffffff),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (play == true) {
                        myaudio.setVolume(00);
                        setState(() {
                          play = !play;
                        });
                      } else {
                        myaudio.setVolume(100);
                        setState(() {
                          play = !play;
                        });
                      }
                    },
                    icon: play
                        ? Icon(
                            Icons.volume_up_rounded,
                            color: Color(0xffffffff),
                          )
                        : Icon(
                            Icons.volume_off,
                            color: Color(0xffffffff),
                          ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: myaudio.currentPosition,
                builder: (context, snapshot) {
                  Duration data = snapshot.data ?? Duration(seconds: 0);
                  try {
                    totalDuration = myaudio.current.value?.audio.duration;
                  } catch (e) {
                    totalDuration = Duration(seconds: 0);
                  }
                  return Column(
                    children: [
                      Slider(
                          min: 0,
                          max: totalDuration!.inSeconds.toDouble(),
                          value: data.inSeconds.toDouble(),
                          onChanged: (val) {
                            myaudio.seek(Duration(seconds: val.toInt()));
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${data.toString().split(".")[0]}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                            Text(
                              "${totalDuration.toString().split(".")[0]}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );

                },
              ),
              Image.network(
                "https://i.pinimg.com/originals/c6/c1/1d/c6c11d8ba0b9f26caf0a6a8ee3a3e78e.gif",
                height: 200,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
