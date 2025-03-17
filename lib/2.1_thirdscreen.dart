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
  bool hasDivideCellButtonBeenUsed = UserSimplePreferences.getHasDivideCellButtonBeenUsed();
  bool canShowDivideCellButton = false;
  Trivia myTrivia = Trivia();
  Random random = Random();
  bool cytodoroDone = UserSimplePreferences.getCytodoroDone();

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

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isGameCompleted) {
        setState(() {
          cellCount++;
          UserSimplePreferences.setCellNumber(cellCount);
          isGameCompleted = false;
        });
      }
    });

    canShowDivideCellButton =
        UserSimplePreferences.getCanShowDivideCellButton();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playButtonClickSound() {
    _audioPlayer.open(
      Audio("assets/tap.mp3"),
      autoStart: true,
      showNotification: false,
    );
  }

  void completeGameSession() {
    setState(() {
      isGameCompleted = true;
    });
    _playButtonClickSound();
    _animationController.reset();
    _animationController.forward();
  }

  void divideCell() {
    if (!cytodoroDone) {
      Navigator.pushNamed(context, '/pie_chartscreen');
      cytodoroDone = true;
      UserSimplePreferences.setCytodoroDone(cytodoroDone);
    } else {
      if (!UserSimplePreferences.getHasDivideCellButtonBeenUsed()) {
        setState(() {
          hasDivideCellButtonBeenUsed = true;
          UserSimplePreferences.setHasDivideCellButtonBeenUsed(hasDivideCellButtonBeenUsed);
          cellCount++;
          UserSimplePreferences.setCellNumber(cellCount);
        });
        _playButtonClickSound();
        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  void startGame() {
    setState(() {
      cellCount = 1;
      UserSimplePreferences.setCellNumber(cellCount);
    });
    _playButtonClickSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY PETRI DISH'),
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
              mainAxisSize: MainAxisSize.min, // Added line
              children: <Widget>[
                SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      // Wrap List.generate in a Column
                      mainAxisSize:
                          MainAxisSize.min, // Important for shrink-wrapping
                      children: List.generate(cellCount, (index) {
                        return AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: (index == cellCount - 1 && isGameCompleted)
                                  ? _scaleAnimation.value
                                  : 1.0,
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
                  ),
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
                          ? Colors.grey
                          : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: hasDivideCellButtonBeenUsed
                        ? null
                        : () {
                            _playButtonClickSound();
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
                      if (!hasDivideCellButtonBeenUsed) {
                        null;
                      } else {
                        _playButtonClickSound();
                        Future.delayed(Duration(milliseconds: 800), () {
                          Navigator.pushNamed(context, '/pie_chartscreen');
                        });
                        print(
                            "Continue Session button pressed (not yet connected)");
                      }
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
                          ? Colors.grey
                          : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: hasDivideCellButtonBeenUsed
                        ? null
                        : () {
                            _playButtonClickSound();
                            divideCell();
                          },
                    child: const Text(
                      'DIVIDE CELL',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      'DID YOU KNOW? \n${myTrivia.triviaStatements[random.nextInt(9)]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color:  Color(0xfffe8f00),
                          fontWeight: FontWeight.bold, 
                          fontStyle: FontStyle.italic),
                      softWrap: true,
                      maxLines: 5,
                    )),
                // TextButton(
                //   onPressed: () {
                //     Future.delayed(Duration(milliseconds: 800), () {
                //       Navigator.pushNamed(context, '/stats_page');
                //     });
                //   },
                //   child: Text(
                //     "Go to Stats Page",
                //     style: TextStyle(color: Colors.green, fontSize: 10),
                //   ),
                // )
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onDoubleTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(context, '/stats_page');
                });
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
