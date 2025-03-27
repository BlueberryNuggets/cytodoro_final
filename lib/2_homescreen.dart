import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MyHomeScreen extends StatelessWidget {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: TextStyle(
            fontFamily: 'PressStart2P', // Apply custom font
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: ElevatedButton(
        onPressed: () {
          // Play audio when button is pressed
          assetsAudioPlayer.open(
            Audio("assets/tap.mp3"),
          );

          // Navigate to piechart screen
          Navigator.pushNamed(context, '/pie_chartscreen');
        },
        child: Text(
          "See the cell's life",
          style: TextStyle(
            fontFamily: 'PressStart2P', // Apply custom font
          ),
        ),
      ),
    );
  }
}