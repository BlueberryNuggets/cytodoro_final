// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final assetsAudioPlayer = AssetsAudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CYTODORO'),
//         backgroundColor: Colors.yellowAccent,
//       ),
//       body: Stack(
//         children: <Widget>[
//           Image.asset(
//             'assets/homescreen_bg.png',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Container(
//             color: Colors.yellow.withOpacity(0.5), // Optional overlay for better contrast
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Lottie.asset('assets/amoeba_wiggle.json',
//                       width: 300, height: 300),
//                   SizedBox(height: 10),
//                   Image.asset(
//                     'assets/cytodoro.png',
//                     width: 250,
//                     height: 250,
//                   ),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () {
//                       assetsAudioPlayer.open(
//                         Audio("assets/tap.mp3"),
//                       );
//                       Navigator.pushNamed(context, '/gamescreen');
//                     },
//                     child: SvgPicture.asset(
//                       'assets/start_button.svg',
//                       width: 200, // Adjust the size as needed
//                       height: 200, // Adjust the size as needed
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//WITH MEDIA QUERY
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CYTODORO',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'PressStart2P',
            color: const Color.fromARGB(255, 255, 154, 22),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/amoeba_wiggle.json',
                    width: screenWidth > 1080 ? 250 : 350,
                    height: screenHeight < 2400 ? 250 : 350,
                  ),
                  SizedBox(height: screenHeight < 2400 ? 10 : 20),
                  Image.asset(
                    'assets/cytodoro.png',
                    width: screenWidth > 1080 ? 200 : 250, // Phone vs. Laptop
                    height: screenWidth < 2400 ? 200 : 250,
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
