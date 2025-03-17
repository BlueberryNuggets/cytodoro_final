import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class GameScreen extends StatelessWidget {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME TO CYTODORO'),
        backgroundColor: Colors.yellowAccent,
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
            color: Colors.yellow.withOpacity(0.5), // Optional overlay for better contrast
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'WELCOME TO CYTODORO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'CYTODORO is a mobile app that combines the excitement of gamified learning with the productivity-boosting Pomodoro technique. Dive into the cell life cycle through interactive games while managing your study time effectively with customizable timers. Make learning biology fun and efficient!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      assetsAudioPlayer.open(
                        Audio("assets/tap.mp3"),
                      );
                      Navigator.pushNamed(context, '/thirdscreen');
                    },
                    child: Text(
                      'NEXT',
                      style: TextStyle(fontSize: 18, color: Colors.black),
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

// class GameScreen extends StatelessWidget {
//   const GameScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WELCOME TO CYTODORO'),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Container(
//         color: Colors.yellow,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Welcome to Cytodoro, a cell life game integrated with Pomodoro',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24, color: Colors.deepOrangeAccent),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/thirdscreen');
//                 },
//                 child: Text(
//                   'NEXT',
//                   style: TextStyle(fontSize: 18, color: Colors.yellow),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }