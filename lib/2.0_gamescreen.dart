import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class GameScreen extends StatelessWidget {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
           'WELCOME TO CYTODORO',
           style: TextStyle(
            fontSize: 15,
            fontFamily: 'PressStart2P',
            color:  const Color.fromARGB(255, 255, 119, 0),
            fontWeight: FontWeight.bold,
           ),
         ),
        backgroundColor:  Color(0xffffda55),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/homescreen_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.yellow
                .withOpacity(0.5), // Optional overlay for better contrast
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'WELCOME TO \nCYTODORO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                       fontSize: 25,
                       fontFamily: 'PressStart2P',
                       color: const Color.fromARGB(255, 255, 119, 0),
                       fontWeight: FontWeight.bold,
                     ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: Text(
                      'CYTODORO is a mobile app that combines the excitement of gamified learning with the productivity-boosting Pomodoro technique. Dive into the cell life cycle through interactive games while managing your study time effectively with customizable timers. Make learning biology fun and efficient!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                         fontSize: 12,
                         letterSpacing: 0,
                         fontFamily: 'PressStart2P',
                         color: const Color.fromARGB(255, 255, 119, 0),
                       ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      assetsAudioPlayer.open(
                        Audio("assets/tap.mp3"),
                      );
                      Navigator.pushNamed(context, '/thirdscreen');
                    },
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                         fontSize: 18,
                         fontFamily: 'PressStart2P',
                         color: const Color.fromARGB(255, 224, 255, 214),
                       ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
