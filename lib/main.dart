
import 'package:audio_player/homepage.dart';
import 'package:audio_player/splash_screen.dart';
import 'package:audio_player/videos_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'homepage': (context) => homePage(),
        '/': (context) => splashScreen(),
        'videopage' :(context) => videopage(),
      },
    ),
  );
}
