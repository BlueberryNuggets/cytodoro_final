import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:assets_audio_player/assets_audio_player.dart'; // Import assets_audio_player.

// Intro Screen with wiggle animation.
class QuizIntroScreen extends StatefulWidget {
  @override
  State<QuizIntroScreen> createState() => _QuizIntroScreenState();
}

class _QuizIntroScreenState extends State<QuizIntroScreen> {
  @override
  void initState() {
    super.initState();
    _preloadAnimations();
  }

  Future<void> _preloadAnimations() async {
    await Lottie.asset('assets/amoeba_wiggle.json').onReady;
  }

  Future<void> precacheLottie(BuildContext context, String assetPath) async {
    await precacheImage(
      AssetImage(assetPath),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xfffec23f),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/amoeba_wiggle.json', // Intro animation.
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnimationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Learn about Mitosis',
                  style: TextStyle(
                    letterSpacing: -1,
                    wordSpacing: -6,
                    fontSize: 15,
                    fontFamily: 'PressStart2P', // Apply custom font
                    color: const Color.fromARGB(255, 224, 255, 214),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on LottieBuilder {
  get onReady => null;
}

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final List<String> assets = [
    'assets/01_I.json',
    'assets/02_P.json',
    'assets/03_M.json',
    'assets/04_A.json',
    'assets/05_T.json',
    'assets/06_Cytokinesis.json',
  ];

  final List<String> stageNames = [
    "Interphase",
    "Prophase",
    "Metaphase",
    "Anaphase",
    "Telophase",
    "Cytokinesis",
  ];

  final List<String> descriptions = [
    "This is the preparation phase where the cell grows, duplicates its DNA, and gets ready for division. It consists of the G1, S, and G2 phases.",
    "Chromosomes condense, becoming visible under a microscope. The nuclear envelope starts to break down, and spindle fibers begin forming.",
    "Chromosomes align in the center (the metaphase plate) of the cell, and spindle fibers attach to the centromeres of the chromosomes.",
    "The sister chromatids are pulled apart by the spindle fibers and move toward opposite poles of the cell.",
    "The chromosomes reach the poles, decondense back into chromatin, and two new nuclear envelopes form around each set of chromosomes.",
    "This is the final step, where the cell's cytoplasm divides, creating two daughter cells. In animal cells, a cleavage furrow forms, while plant cells develop a cell plate.",
  ];

  int currentIndex = 0;

  final assetsAudioPlayer =
      AssetsAudioPlayer(); // Create audio player instance.

  void _nextAnimation() {
    // Play the tap sound when button is clicked.
    assetsAudioPlayer.open(
      Audio("assets/tap.mp3"),
      autoStart: true,
    );

    setState(() {
      currentIndex = (currentIndex + 1) % assets.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double animationSize = 300;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IPMATC',
          style: TextStyle(
            fontFamily: 'PressStart2P', // Apply custom font
          ),
        ),
        backgroundColor: Color(0xfffec23f),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xfffec23f),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  assets[currentIndex],
                  width: animationSize,
                  height: animationSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextAnimation,
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    stageNames[currentIndex],
                    style: TextStyle(
                      letterSpacing: -1,
                      wordSpacing: -6,
                      fontSize: 15,
                      fontFamily: 'PressStart2P', // Apply custom font
                      color: const Color.fromARGB(255, 224, 255, 214),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    descriptions[currentIndex],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0,
                      wordSpacing: -6,
                      fontSize: 12,
                      fontFamily: 'PressStart2P', // Apply custom font
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                currentIndex == 5
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: () {
                          _nextAnimation();

                          Navigator.pushNamed(context, '/mitosis_quizscreen');
                        },
                        child: Text(
                          'Play Mitosis Game',
                          style: TextStyle(
                            letterSpacing: -1,
                            wordSpacing: -6,
                            fontSize: 15,
                            fontFamily: 'PressStart2P', // Apply custom font
                            color: const Color.fromARGB(255, 224, 255, 214),
                          ),
                        ),
                      )
                    : Container(constraints: BoxConstraints(minHeight: 100)),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 800), () {
                      Navigator.pushNamed(context, '/mitosis_quizscreen');
                    });
                  },
                  child: Text(
                    "Skip to Mitosis Game",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      // fontFamily: 'PressStart2P', // Apply custom font
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
