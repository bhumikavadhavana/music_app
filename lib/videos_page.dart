import 'package:audio_player/utils/video.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videopage extends StatefulWidget {
  const videopage({super.key});

  @override
  State<videopage> createState() => _videopageState();
}

class _videopageState extends State<videopage> {
  late VideoPlayerController videoPlayerController;

  late ChewieController Mychewiecontroller;

  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(videolist[i]['video'])
      ..initialize().then((value) => setState(() {}));
    Mychewiecontroller = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 5 / 2,
        autoPlay: false,
        allowFullScreen: true);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
         "${data['vname']}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: Mychewiecontroller,
              ),
            ),
          ],
        ),
      ),
     backgroundColor: Colors.black,
    );
  }
}
