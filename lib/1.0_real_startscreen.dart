import 'package:connections/8_user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CYTODORO'),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset('assets/amoeba_wiggle.json',
                      width: 300, height: 300),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/cytodoro.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      assetsAudioPlayer.open(
                        Audio("assets/tap.mp3"),
                      );
                      Navigator.pushNamed(context, '/gamescreen');
                    },
                    child: SvgPicture.asset(
                      'assets/start_button.svg',
                      width: 200, // Adjust the size as needed
                      height: 200, // Adjust the size as needed
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


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CYTODORO'),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Container(
//         color: Colors.yellow,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Lottie.asset('assets/amoeba_wiggle.json', width: 230, height: 230),
//               SizedBox(height: 20),
//               Text(
//                 'CYTODORO',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepOrangeAccent,
//                 ),
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
//                   Navigator.pushNamed(context, '/gamescreen');
//                 },
//                 child: Text(
//                   'START',
//                   style: TextStyle(fontSize: 25, color: Colors.yellow),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



