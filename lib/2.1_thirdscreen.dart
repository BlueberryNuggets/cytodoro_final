import 'dart:math';
import 'package:connections/2.2_trivia.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connections/8_user_simple_preferences.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  int cellCount = UserSimplePreferences.getCellNumber();
  bool isGameCompleted = false;
  bool hasDivideCellButtonBeenUsed = false; // Tracks if the "Divide Cell" button has been used
  bool canShowDivideCellButton = false; // Tracks if the divide cell button can be shown
  Trivia myTrivia = Trivia();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Add a listener to update the UI after animation ends
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isGameCompleted) {
        setState(() {
          cellCount++; // Increment cell count
          UserSimplePreferences.setCellNumber(cellCount);
          isGameCompleted = false; // Reset game completion status
        });
      }
    });

    // Check if the divide cell button can be shown based on user preferences
    canShowDivideCellButton = UserSimplePreferences.getCanShowDivideCellButton();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose(); // Dispose the audio player instance
    super.dispose();
  }

  // Function to play the button click sound
  void _playButtonClickSound() {
    _audioPlayer.open(
      Audio("assets/tap.mp3"), // Specify the audio file
      autoStart: true, // Start playing automatically
      showNotification: false, // Don't show notification
    );
  }

  // Simulating game session completion
  void completeGameSession() {
    setState(() {
      isGameCompleted = true; // Mark the game session as completed
    });
    _playButtonClickSound(); // Play sound when button is clicked
    _animationController.reset();
    _animationController.forward(); // Trigger the multiplication animation
  }

  // Function to divide the cell and play animation
  void divideCell() {
    if (!hasDivideCellButtonBeenUsed) {
      setState(() {
        hasDivideCellButtonBeenUsed = true; // Mark the button as used
        cellCount++; // Increment cell count directly
        UserSimplePreferences.setCellNumber(cellCount); // Save the updated cell count
      });
      _playButtonClickSound(); // Play sound effect
      _animationController.reset();
      _animationController.forward(); // Start the scaling animation
    }
  }

  // Function to start the game
  void startGame() {
    setState(() {
      cellCount = 1; // Reset cell count to 1
      UserSimplePreferences.setCellNumber(cellCount); // Save the updated cell count
    });
    _playButtonClickSound(); // Play sound effect
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME SCREEN'),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(cellCount, (index) {
                    return AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: (index == cellCount - 1 && isGameCompleted)
                              ? _scaleAnimation.value
                              : 1.0, // Scale only the latest cell during animation
                          child: Lottie.asset(
                            'assets/amoeba_wiggle.json',
                            width: 100,
                            height: 100,
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                if (cellCount == 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      startGame();
                    },
                    child: const Text(
                      'START',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                if (cellCount > 1) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasDivideCellButtonBeenUsed
                          ? Colors.grey // Disabled state
                          : Colors.green, // Active state
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: hasDivideCellButtonBeenUsed
                        ? null
                        : () {
                      _playButtonClickSound(); // Play sound when button is clicked
                      divideCell();
                    },
                    child: const Text(
                      'DIVIDE CELL',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      _playButtonClickSound(); // Play sound when button is clicked
                      Future.delayed(Duration(milliseconds: 800), () {
                        // Delay for 2 seconds
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, '/pie_chartscreen');
                      });
                      print("Continue Session button pressed (not yet connected)");
                    },
                    child: const Text(
                      'CONTINUE SESSION',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
                if (cellCount == 1 || canShowDivideCellButton)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasDivideCellButtonBeenUsed
                          ? Colors.grey // Disabled state
                          : Colors.green, // Active state
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: hasDivideCellButtonBeenUsed
                        ? null
                        : () {
                      _playButtonClickSound(); // Play sound when button is clicked
                      divideCell();
                    },
                    child: const Text(
                      'DIVIDE CELL',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                Container(margin: EdgeInsets.all(16), child: Text('Did you know? \n${myTrivia.triviaStatements[random.nextInt(9)]}', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.8), fontWeight: FontWeight.w400), softWrap: true, maxLines: 5,)) // Modify number of trivia statements
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onDoubleTap: () {
                Navigator.pushNamed(context, '/stats_page');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(children: [
                  Text(
                    'Cell Count: ${UserSimplePreferences.getCellNumber()}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    'Total Score: ${UserSimplePreferences.getTotalScore()}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';


// class ThirdScreen extends StatelessWidget {
//   final int cellCount = 0; // Default cell count


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOME SCREEN'),
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
//                 children: <Widget>[
//                   Lottie.asset('assets/amoeba_wiggle.json', width: 250, height: 250),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     ),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/pie_chartscreen');
//                     },
//                     child: Text(
//                       'BEGIN',
//                       style: TextStyle(fontSize: 18, color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 20,
//             right: 20,
//             child: GestureDetector(
//               onDoubleTap: () {Navigator.pushNamed(context, '/stats_page');},
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Cell Count: $cellCount',
//                       style: TextStyle(fontSize: 18, color: Colors.black),
//                     ),
//                     Text(
//                       'Total Score: ${UserSimplePreferences.getTotalScore()}',
//                       style: TextStyle(fontSize: 18, color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }