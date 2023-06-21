import 'package:audio_player/utils/video.dart';
import 'package:audio_player/videos_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class video extends StatefulWidget {
  const video({super.key});

  @override
  State<video> createState() => _videoState();
}

class _videoState extends State<video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.video_collection,
                color: Colors.white,
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                "Latest video",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 0.6,
                  enlargeCenterPage: true,
                  onPageChanged: (val, _) {
                    setState(() {
                      i = val;
                    });
                  }),
              items: videolist
                  .map((e) => Stack(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(e['photo']),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'videopage',
                                      arguments: videolist[i]);
                                },
                                icon: Icon(
                                  Icons.play_circle,
                                  color: Colors.blue,
                                  size: 40,
                                )),
                          ),
                        ],
                      ))
                  .toList(),
            ),
            Divider(
              color: Colors.white,
            ),
            Text("All Videos",style: TextStyle(fontSize: 23,color: Colors.white),),
            Divider(color: Colors.white,),
            Column(
              children: videolist
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        i = videolist.indexOf(e);
                        Navigator.of(context)
                            .pushNamed('videopage', arguments: videolist[i]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 200,
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                                image: AssetImage(
                                  e['photo'],
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.play_circle,
                            color: Colors.blue,
                            size: 45,
                          ),
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
