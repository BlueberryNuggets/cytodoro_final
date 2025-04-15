import 'dart:math';
// ignore: library_prefixes
import 'dart:math' as dartMath;
import 'package:connections/4_dnaGame_files/bases_buttons.dart';
import 'package:connections/8_user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:connections/4_dnaGame_files/nitrogenous_base.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MyDNAGameScreen extends StatefulWidget {
  const MyDNAGameScreen({super.key});

  @override
  State<MyDNAGameScreen> createState() => _MyDNAGameScreenState();
}

class _MyDNAGameScreenState extends State<MyDNAGameScreen> {
  int answerItem = 0;
  List<NitrogenousBase> dnaStrand = [];
  int score = 0; //IN SHARED PREF
  bool gameStarted = false;
  bool startButtonVisible = true;
  String feedbackText = "";
  bool showFeedback = false;
  String endGameMessage = "";
  bool gameEnded = false;
  int incorrectBases = 0;
  int failedGame = 0;
  int overallScore = 0;
  int accuracyRate = 0;
  int baseLength = 30;
  int netAccuracy = UserSimplePreferences.getdnaAccuracy();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  final ScrollController _scrollController1 = ScrollController();
  int speedControl = 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  void disposeSound() {
    _audioPlayer.dispose();
  }

  void playSound() {
    _audioPlayer.open(
      Audio('assets/dna_bgmusic.mp3'),
      autoStart: true,
      loopMode: LoopMode.single,
    );
    _audioPlayer.setVolume(0.2);
  }

  void startGame() {
    setState(() {
      playSound();
      gameStarted = true;
      startButtonVisible = false;
      createDNAstrand();
      gameEnded = false;
      endGameMessage = "";
      incorrectBases = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
        animateToMaxMin(maxScrollExtent1, 0, maxScrollExtent1, speedControl,
            _scrollController1);
      });
    });
  }

  void animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController.animateTo(direction,
        duration: Duration(seconds: seconds), curve: Curves.linear);
  }

  void createDNAstrand() {
    setState(() {
      dnaStrand.clear();
      for (int i = 0; i < baseLength; i++) {
        final randomNumber = Random().nextInt(4);
        String nucleotide = "";
        switch (randomNumber) {
          case 0:
            nucleotide = "A";
            break;
          case 1:
            nucleotide = "T";
            break;
          case 2:
            nucleotide = "C";
            break;
          case 3:
            nucleotide = "G";
            break;
        }
        dnaStrand.add(NitrogenousBase(baseType: nucleotide, baseChosen: ""));
      }
      answerItem = 0;
      score = 0;
    });
  }

  Future<void> adenine() async {
    _updateBaseAtIndex(answerItem, "A");
  }

  Future<void> thymine() async {
    _updateBaseAtIndex(answerItem, "T");
  }

  Future<void> guanine() async {
    _updateBaseAtIndex(answerItem, "G");
  }

  Future<void> cytosine() async {
    _updateBaseAtIndex(answerItem, "C");
  }

  void _updateBaseAtIndex(int index, String base) async {
    if (index >= 0 && index < dnaStrand.length) {
      String correctBase = "";
      switch (dnaStrand[index].baseType) {
        case "A":
          correctBase = "T";
          break;
        case "T":
          correctBase = "A";
          break;
        case "C":
          correctBase = "G";
          break;
        case "G":
          correctBase = "C";
          break;
      }

      List<NitrogenousBase> newDnaStrand = List.from(dnaStrand);
      newDnaStrand[index] = NitrogenousBase(
        baseType: dnaStrand[index].baseType,
        baseChosen: base,
      );
      setState(() {
        dnaStrand = newDnaStrand;
        if (base == correctBase) {
          score += 100;
          feedbackText = "You're right! ❤️";
        } else {
          score -= 50;
          feedbackText = "Incorrect ❌";
          incorrectBases++;
        }
        showFeedback = true;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            showFeedback = false;
          });
        });

        answerItem++;
        if (answerItem >= dnaStrand.length) {
          answerItem = dnaStrand.length - 1;
          gameEnded = true;
          UserSimplePreferences.setdnaScore(score);
          overallScore = UserSimplePreferences.getTotalScore() +
              UserSimplePreferences.getdnaScore();
          UserSimplePreferences.setTotalScore(overallScore);
          if (incorrectBases > 5) {
            endGameMessage =
                "You might've just caused a mutation in this amoeba. You got $incorrectBases incorrect nitrogen bases.🧬⚠️";
            failedGame = 2;
          } else if (incorrectBases <= 5 && incorrectBases > 1) {
            endGameMessage =
                "You got $incorrectBases incorrect nitrogen bases. Just a few proofreading with DNA polymerase!🧬🚨";
            failedGame = Random().nextInt(2) + 1;
          } else if (incorrectBases == 1) {
            endGameMessage = "So close! Only 1 incorrect base.🧬";
            failedGame = 1;
          } else {
            endGameMessage =
                "Wow, you've perfectly replicated the amoeba's DNA!🧬✨";
            failedGame = 0;
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController1.animateTo(
              _scrollController1.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black),
                ),
                width: 300,
                alignment: Alignment.topRight,
                child: Text(
                  "Score: $score",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                flex: 4,
                child: Container(
                  color: const Color(0xfffff9f3),
                  child: Stack(
                    children: [
                      Center(
                        child: gameStarted
                            ? Container(
                                alignment: const Alignment(0, 0.5),
                                height: 500,
                                child: ListView.builder(
                                  controller: _scrollController1,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dnaStrand.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0 && !gameEnded) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100.0),
                                        child: dnaStrand[index],
                                      );
                                    } else {
                                      return dnaStrand[index];
                                    }
                                  },
                                ),
                              )
                            : const Center(
                                child: Text(
                                  "Are you ready to replicate some DNA? \n",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                      ),
                      if (gameStarted)
                        Container(
                          alignment: const Alignment(0, 0.554),
                          child: Container(
                            width: 700,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xfffe8f00),
                              border:
                                  Border.all(width: 1.2, color: Colors.black),
                            ),
                          ),
                        ),
                      if (gameStarted)
                        Container(
                          alignment: const Alignment(0, -0.72),
                          child: Container(
                            width: 700,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xfffe8f00),
                              border:
                                  Border.all(width: 1.2, color: Colors.black),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xfffff78b),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(
                        letter: "A",
                        function: adenine,
                        color: const Color(0xffc660e8),
                      ),
                      MyButton(
                        letter: "T",
                        function: thymine,
                        color: const Color(0xffffda55),
                      ),
                      MyButton(
                        letter: "C",
                        function: cytosine,
                        color: const Color(0xffffb7b7),
                      ),
                      MyButton(
                        letter: "G",
                        function: guanine,
                        color: const Color(0xffa7d648),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: startButtonVisible
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    onPressed: startGame,
                    child: const Text('START GAME',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  )
                : Container(),
          ),
          if (showFeedback)
            AnimatedOpacity(
              opacity: showFeedback ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 400),
                  child: Text(
                    feedbackText,
                    style:
                        const TextStyle(fontSize: 22, color: Color(0xfffe8f00)),
                  ),
                ),
              ),
            ),
          if (gameEnded)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xffffd25e),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 231, 153, 52)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      endGameMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  onPressed: () {
                    disposeSound();
                    Navigator.pushNamed(
                      context,
                      '/pie_chartscreen',
                    );

                    if (score == 3000) {
                      netAccuracy = netAccuracy + 1;
                      UserSimplePreferences.setdnaAccuracy(netAccuracy);
                    }
                  },
                  child: const Text('Go back to your cell',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
// import 'dart:math';
// import 'package:connections/4_dnaGame_files/bases_buttons.dart';
// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:connections/4_dnaGame_files/nitrogenous_base.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

// class MyDNAGameScreen extends StatefulWidget {
//   const MyDNAGameScreen({super.key});

//   @override
//   State<MyDNAGameScreen> createState() => _MyDNAGameScreenState();
// }

// class _MyDNAGameScreenState extends State<MyDNAGameScreen> {
//   int answerItem = 0;
//   List<NitrogenousBase> dnaStrand = [];
//   int score = 0; //IN SHARED PREF
//   bool gameStarted = false;
//   bool startButtonVisible = true;
//   String feedbackText = "";
//   bool showFeedback = false;
//   String endGameMessage = "";
//   bool gameEnded = false;
//   int incorrectBases = 0;
//   int failedGame =
//       0; //IN SHARED PREF; 0 = perfect; 1 = minor mutation; 2 = major mutation
//   int overallScore = 0;
//   int accuracyRate = 0;
//   int baseLength = 30;
//   // int rate_add = UserSimplePreferences.getdnaRateAdd();
//   int netAccuracy = UserSimplePreferences.getdnaAccuracy();
//   final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

//   final ScrollController _scrollController1 = ScrollController();
//   int speedControl = 20;

//   // final player = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _audioPlayer.dispose();
//   }

//   void disposeSound() {
//     _audioPlayer.dispose(); // Dispose of audio player
//   }

//   void playSound() {
//     _audioPlayer.open(
//       Audio('assets/dna_bgmusic.mp3'),
//       autoStart: true,
//       loopMode: LoopMode.single,
//     );
//     _audioPlayer.setVolume(0.2);
//   }

//   void startGame() {
//     setState(() {
//       playSound();
//       gameStarted = true;
//       startButtonVisible = false;
//       createDNAstrand();
//       gameEnded = false;
//       endGameMessage = "";
//       incorrectBases = 0;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
//         animateToMaxMin(maxScrollExtent1, 0, maxScrollExtent1, speedControl,
//             _scrollController1);
//       });
//     });
//   }

//   void animateToMaxMin(double max, double min, double direction, int seconds,
//       ScrollController scrollController) {
//     scrollController.animateTo(direction,
//         duration: Duration(seconds: seconds), curve: Curves.linear);
//   }

//   void createDNAstrand() {
//     setState(() {
//       dnaStrand.clear();
//       for (int i = 0; i < baseLength; i++) {
//         final randomNumber = Random().nextInt(4);
//         String nucleotide = "";
//         switch (randomNumber) {
//           case 0:
//             nucleotide = "A";
//             break;
//           case 1:
//             nucleotide = "T";
//             break;
//           case 2:
//             nucleotide = "C";
//             break;
//           case 3:
//             nucleotide = "G";
//             break;
//         }
//         dnaStrand.add(NitrogenousBase(baseType: nucleotide, baseChosen: ""));
//       }
//       answerItem = 0;
//       score = 0;
//     });
//   }

//   Future<void> adenine() async {
//     _updateBaseAtIndex(answerItem, "A");
//   }

//   Future<void> thymine() async {
//     _updateBaseAtIndex(answerItem, "T");
//   }

//   Future<void> guanine() async {
//     _updateBaseAtIndex(answerItem, "G");
//   }

//   Future<void> cytosine() async {
//     _updateBaseAtIndex(answerItem, "C");
//   }

//   void _updateBaseAtIndex(int index, String base) async {
//     if (index >= 0 && index < dnaStrand.length) {
//       String correctBase = "";
//       switch (dnaStrand[index].baseType) {
//         case "A":
//           correctBase = "T";
//           break;
//         case "T":
//           correctBase = "A";
//           break;
//         case "C":
//           correctBase = "G";
//           break;
//         case "G":
//           correctBase = "C";
//           break;
//       }

//       List<NitrogenousBase> newDnaStrand = List.from(dnaStrand);
//       newDnaStrand[index] = NitrogenousBase(
//         baseType: dnaStrand[index].baseType,
//         baseChosen: base,
//       );
//       setState(() {
//         dnaStrand = newDnaStrand;
//         if (base == correctBase) {
//           score += 100;
//           feedbackText = "You're right! ❤️";
//         } else {
//           score -= 50;
//           feedbackText = "Incorrect ❌";
//           incorrectBases++;
//         }
//         showFeedback = true;
//         Future.delayed(const Duration(seconds: 1), () {
//           setState(() {
//             showFeedback = false;
//           });
//         });

//         answerItem++;
//         if (answerItem >= dnaStrand.length) {
//           answerItem = dnaStrand.length - 1;
//           gameEnded = true;
//           UserSimplePreferences.setdnaScore(score);
//           overallScore = UserSimplePreferences.getTotalScore() +
//               UserSimplePreferences.getdnaScore();
//           UserSimplePreferences.setTotalScore(overallScore);
//           if (incorrectBases > 5) {
//             endGameMessage =
//                 "You might've just caused a mutation in this amoeba. You got $incorrectBases incorrect nitrogen bases.🧬⚠️";
//             failedGame = 2;
//           } else if (incorrectBases <= 5 && incorrectBases > 1) {
//             endGameMessage =
//                 "You got $incorrectBases incorrect nitrogen bases. Just a few proofreading with DNA polymerase!🧬🚨";
//             failedGame = Random().nextInt(2) + 1;
//           } else if (incorrectBases == 1) {
//             endGameMessage = "So close! Only 1 incorrect base.🧬";
//             failedGame = 1;
//           } else {
//             endGameMessage =
//                 "Wow, you've perfectly replicated the amoeba's DNA!🧬✨";
//             failedGame = 0;
//           }

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _scrollController1.animateTo(
//               _scrollController1.position.minScrollExtent,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//             );
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(height: 30),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1.5, color: Colors.black),
//                 ),
//                 width: 300,
//                 alignment: Alignment.topRight,
//                 child: Text(
//                   "Score: $score",
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),
//               Expanded(
//                 flex: 4,
//                 child: Container(
//                   color: Color(0xfffff9f3),
//                   child: Stack(
//                     children: [
//                       Center(
//                         child: gameStarted
//                             ? Container(
//                                 alignment: const Alignment(0, 0.5),
//                                 height: 500,
//                                 child: ListView.builder(
//                                   controller: _scrollController1,
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: dnaStrand.length,
//                                   itemBuilder: (context, index) {
//                                     if (index == 0 && !gameEnded) {
//                                       return Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 100.0), // Adjust as needed
//                                         child: dnaStrand[index],
//                                       );
//                                     } else {
//                                       return dnaStrand[index];
//                                     }
//                                   },
//                                 ),
//                               )
//                             : const Center(
//                                 child: Text(
//                                   "Are you ready to replicate some DNA? \n",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                       ),
//                       if (gameStarted) // Show black strips only when game is started
//                         Container(
//                           alignment: const Alignment(0, 0.554),
//                           child: Container(
//                             width: 700,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: Color(0xfffe8f00),
//                               border:
//                                   Border.all(width: 1.2, color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       if (gameStarted) // Show black strips only when game is started
//                         Container(
//                           alignment: const Alignment(0, -0.72),
//                           child: Container(
//                             width: 700,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: Color(0xfffe8f00),
//                               border:
//                                   Border.all(width: 1.2, color: Colors.black),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Color(0xfffff78b),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       MyButton(
//                         letter: "A",
//                         function: adenine,
//                         color: Color(0xffc660e8),
//                       ),
//                       MyButton(
//                         letter: "T",
//                         function: thymine,
//                         color: Color(0xffffda55),
//                       ),
//                       MyButton(
//                         letter: "C",
//                         function: cytosine,
//                         color: Color(0xffffb7b7),
//                       ),
//                       MyButton(
//                         letter: "G",
//                         function: guanine,
//                         color: Color(0xffa7d648),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Center(
//             child: startButtonVisible
//                 ? ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 15),
//                     ),
//                     onPressed: startGame,
//                     child: Text('START GAME',
//                         style: TextStyle(fontSize: 18, color: Colors.white)),
//                   )
//                 : Container(),
//           ),
//           if (showFeedback)
//             AnimatedOpacity(
//               opacity: showFeedback ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 500),
//               child: Center(
//                 child: Container(
//                   margin: const EdgeInsets.only(top: 400),
//                   child: Text(
//                     feedbackText,
//                     style:
//                         const TextStyle(fontSize: 22, color: Color(0xfffe8f00)),
//                   ),
//                 ),
//               ),
//             ),
//           if (gameEnded)
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Color(0xffffd25e),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color.fromARGB(255, 231, 153, 52)
//                             .withOpacity(0.5), // Shadow color with 50% opacity
//                         spreadRadius: 5,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Text(
//                       endGameMessage,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 22),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     elevation: 10,
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 15),
//                   ),
//                   onPressed: () {
//                     disposeSound();
//                     Navigator.pushNamed(
//                       context,
//                       '/pie_chartscreen',
//                     );
//                     //FUNCTION THAT SETS THE ACCURACY RATE
//                     if (score == 3000) {
//                       netAccuracy = netAccuracy + 1;
//                       UserSimplePreferences.setdnaAccuracy(netAccuracy);
//                     }
//                   },
//                   child: Text('Go back to your cell',
//                       style: TextStyle(fontSize: 18, color: Colors.white)),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// // import 'dart:math';
// // import 'package:connections/4_dnaGame_files/bases_buttons.dart';
// // import 'package:connections/8_user_simple_preferences.dart';
// // import 'package:flutter/material.dart';
// // import 'package:connections/4_dnaGame_files/nitrogenous_base.dart';
// // import 'package:assets_audio_player/assets_audio_player.dart';

// // class MyDNAGameScreen extends StatefulWidget {
// //   const MyDNAGameScreen({super.key});

// //   @override
// //   State<MyDNAGameScreen> createState() => _MyDNAGameScreenState();
// // }

// // class _MyDNAGameScreenState extends State<MyDNAGameScreen> {
// //   int answerItem = 0;
// //   List<NitrogenousBase> dnaStrand = [];
// //   int score = 0; //IN SHARED PREF
// //   bool gameStarted = false;
// //   bool startButtonVisible = true;
// //   String feedbackText = "";
// //   bool showFeedback = false;
// //   String endGameMessage = "";
// //   bool gameEnded = false;
// //   int incorrectBases = 0;
// //   int failedGame =
// //       0; //IN SHARED PREF; 0 = perfect; 1 = minor mutation; 2 = major mutation
// //   int overallScore = 0;
// //   int accuracyRate = 0;
// //   int baseLength = 30;
// //   int netAccuracy = UserSimplePreferences.getdnaAccuracy();
// //   final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
// //   final AssetsAudioPlayer _audioPlayer1 = AssetsAudioPlayer();

// //   final ScrollController _scrollController1 = ScrollController();
// //   int speedControl = 20;

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _audioPlayer.dispose();
// //     _audioPlayer1.dispose();
// //   }

// //   void playSound() {
// //     _audioPlayer.open(
// //       Audio('assets/dna_bgmusic.mp3'),
// //       autoStart: true,
// //       loopMode: LoopMode.single,
// //     );
// //     _audioPlayer.setVolume(0.2);
// //   }

// //   void playRightfx() {
// //     _audioPlayer1.open(
// //       Audio('assets/right.mp3'),
// //       autoStart: true,
// //     );
// //   }

// //   void playWrongfx() {
// //     _audioPlayer1.open(
// //       Audio('assets/wrong.mp3'),
// //       autoStart: true,
// //     );
// //   }

// //   void disposeSound() {
// //     _audioPlayer.dispose(); // Dispose of audio player
// //     _audioPlayer1.dispose();
// //   }

// //   void startGame() {
// //     setState(() {
// //       playSound();
// //       gameStarted = true;
// //       startButtonVisible = false;
// //       createDNAstrand();
// //       gameEnded = false;
// //       endGameMessage = "";
// //       incorrectBases = 0;
// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //         double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
// //         animateToMaxMin(maxScrollExtent1, 0, maxScrollExtent1, speedControl,
// //             _scrollController1);
// //       });
// //     });
// //   }

// //   void animateToMaxMin(double max, double min, double direction, int seconds,
// //       ScrollController scrollController) {
// //     scrollController.animateTo(direction,
// //         duration: Duration(seconds: seconds), curve: Curves.linear);
// //   }

// //   void createDNAstrand() {
// //     setState(() {
// //       dnaStrand.clear();
// //       for (int i = 0; i < baseLength; i++) {
// //         final randomNumber = Random().nextInt(4);
// //         String nucleotide = "";
// //         switch (randomNumber) {
// //           case 0:
// //             nucleotide = "A";
// //             break;
// //           case 1:
// //             nucleotide = "T";
// //             break;
// //           case 2:
// //             nucleotide = "C";
// //             break;
// //           case 3:
// //             nucleotide = "G";
// //             break;
// //         }
// //         dnaStrand.add(NitrogenousBase(baseType: nucleotide, baseChosen: ""));
// //       }
// //       answerItem = 0;
// //       score = 0;
// //     });
// //   }

// //   Future<void> adenine() async {
// //     _updateBaseAtIndex(answerItem, "A");
// //   }

// //   Future<void> thymine() async {
// //     _updateBaseAtIndex(answerItem, "T");
// //   }

// //   Future<void> guanine() async {
// //     _updateBaseAtIndex(answerItem, "G");
// //   }

// //   Future<void> cytosine() async {
// //     _updateBaseAtIndex(answerItem, "C");
// //   }

// //   void _updateBaseAtIndex(int index, String base) async {
// //   if (index >= 0 && index < dnaStrand.length) {
// //     String correctBase = "";
// //     switch (dnaStrand[index].baseType) {
// //       case "A":
// //         correctBase = "T";
// //         break;
// //       case "T":
// //         correctBase = "A";
// //         break;
// //       case "C":
// //         correctBase = "G";
// //         break;
// //       case "G":
// //         correctBase = "C";
// //         break;
// //     }

// //     List<NitrogenousBase> newDnaStrand = List.from(dnaStrand);
// //     newDnaStrand[index] = NitrogenousBase(
// //       baseType: dnaStrand[index].baseType,
// //       baseChosen: base,
// //     );
// //     setState(() {
// //       dnaStrand = newDnaStrand;
// //       if (base == correctBase) {
// //         score += 100;
// //         feedbackText = "You're right! ❤️";
// //         playRightfx();
// //       } else {
// //         score -= 50;
// //         feedbackText = "Incorrect ❌";
// //         playWrongfx();
// //         incorrectBases++;
// //       }
// //       showFeedback = true;
// //       Future.delayed(const Duration(seconds: 1), () {
// //         setState(() {
// //           showFeedback = false;
// //         });
// //       });

// //       answerItem++;
// //       if (answerItem >= dnaStrand.length - (dnaStrand.length / 5)) {
// //         speedControl = 35;
// //       } else if (answerItem >= dnaStrand.length - (dnaStrand.length / 4)) {
// //         speedControl = 30;
// //       } else if (answerItem >= dnaStrand.length - (dnaStrand.length / 3)) {
// //         speedControl = 28;
// //       } else if (answerItem >= dnaStrand.length - (dnaStrand.length / 2)) {
// //         speedControl = 25;
// //       } else if (answerItem >= dnaStrand.length) {
// //         WidgetsBinding.instance.addPostFrameCallback((_) { // Use addPostFrameCallback
// //           answerItem = dnaStrand.length - 1;
// //           gameEnded = true;
// //           UserSimplePreferences.setdnaScore(score);
// //           overallScore = UserSimplePreferences.getTotalScore() +
// //               UserSimplePreferences.getdnaScore();
// //           UserSimplePreferences.setTotalScore(overallScore);
// //           if (incorrectBases > 5) {
// //             endGameMessage =
// //                 "You might've just caused a mutation in this amoeba. You got $incorrectBases incorrect nitrogen bases.🧬⚠️";
// //             failedGame = 2;
// //           } else if (incorrectBases <= 5 && incorrectBases > 1) {
// //             endGameMessage =
// //                 "You got $incorrectBases incorrect nitrogen bases. Just a few proofreading with DNA polymerase!🧬🚨";
// //             failedGame = Random().nextInt(2) + 1;
// //           } else if (incorrectBases == 1) {
// //             endGameMessage = "So close! Only 1 incorrect base.🧬";
// //             failedGame = 1;
// //           } else {
// //             endGameMessage =
// //                 "Wow, you've perfectly replicated the amoeba's DNA!🧬✨";
// //             failedGame = 0;
// //           }

// //           WidgetsBinding.instance.addPostFrameCallback((_) {
// //             _scrollController1.animateTo(
// //               _scrollController1.position.minScrollExtent,
// //               duration: const Duration(milliseconds: 500),
// //               curve: Curves.easeInOut,
// //             );
// //           });
// //           setState(() {}); // Trigger a rebuild after all end game logic.
// //         });
// //       }
// //     });
// //   }
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Column(
// //             children: [
// //               SizedBox(height: 30),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   border: Border.all(width: 1.5, color: Colors.black),
// //                 ),
// //                 width: 300,
// //                 alignment: Alignment.topRight,
// //                 child: Text(
// //                   "Score: $score",
// //                   style: const TextStyle(
// //                     fontSize: 20,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 15),
// //               Expanded(
// //                 flex: 4,
// //                 child: Container(
// //                   color: Color(0xfffff9f3),
// //                   child: Stack(
// //                     children: [
// //                       Center(
// //                         child: gameStarted
// //                             ? Container(
// //                                 alignment: const Alignment(0, 0.5),
// //                                 height: 500,
// //                                 child: ListView.builder(
// //                                   controller: _scrollController1,
// //                                   scrollDirection: Axis.horizontal,
// //                                   itemCount: dnaStrand.length,
// //                                   itemBuilder: (context, index) {
// //                                     if (index == 0 && !gameEnded) {
// //                                       return Padding(
// //                                         padding: const EdgeInsets.only(
// //                                             left: 100.0), // Adjust as needed
// //                                         child: dnaStrand[index],
// //                                       );
// //                                     } else {
// //                                       return dnaStrand[index];
// //                                     }
// //                                   },
// //                                 ),
// //                               )
// //                             : const Center(
// //                                 child: Text(
// //                                   "Are you ready to replicate some DNA? \n",
// //                                   textAlign: TextAlign.center,
// //                                   style: TextStyle(
// //                                       fontSize: 22,
// //                                       fontWeight: FontWeight.w400),
// //                                 ),
// //                               ),
// //                       ),
// //                       if (gameStarted)
// //                         Container(
// //                           alignment: const Alignment(0, 0.554),
// //                           child: Container(
// //                             width: 700,
// //                             height: 30,
// //                             decoration: BoxDecoration(
// //                               color: Color(0xfffe8f00),
// //                               border:
// //                                   Border.all(width: 1.2, color: Colors.black),
// //                             ),
// //                           ),
// //                         ),
// //                       if (gameStarted)
// //                         Container(
// //                           alignment: const Alignment(0, -0.72),
// //                           child: Container(
// //                             width: 700,
// //                             height: 30,
// //                             decoration: BoxDecoration(
// //                               color: Color(0xfffe8f00),
// //                               border:
// //                                   Border.all(width: 1.2, color: Colors.black),
// //                             ),
// //                           ),
// //                         ),
// //                       Positioned.fill(
// //                         child: Image.asset(
// //                           'assets/stack_cover.png',
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: Container(
// //                   color: Color(0xfffff78b),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       MyButton(
// //                         letter: "A",
// //                         function: adenine,
// //                         color: Color(0xffc660e8),
// //                       ),
// //                       MyButton(
// //                         letter: "T",
// //                         function: thymine,
// //                         color: Color(0xffffda55),
// //                       ),
// //                       MyButton(
// //                         letter: "C",
// //                         function: cytosine,
// //                         color: Color(0xffffb7b7),
// //                       ),
// //                       MyButton(
// //                         letter: "G",
// //                         function: guanine,
// //                         color: Color(0xffa7d648),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Center(
// //             child: startButtonVisible
// //                 ? ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.green,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 15),
// //                     ),
// //                     onPressed: startGame,
// //                     child: Text('START GAME',
// //                         style: TextStyle(fontSize: 18, color: Colors.white)),
// //                   )
// //                 : Container(),
// //           ),
// //           if (showFeedback)
// //             AnimatedOpacity(
// //               opacity: showFeedback ? 1.0 : 0.0,
// //               duration: const Duration(milliseconds: 500),
// //               child: Center(
// //                 child: Container(
// //                   margin: const EdgeInsets.only(top: 400),
// //                   child: Text(
// //                     feedbackText,
// //                     style:
// //                         const TextStyle(fontSize: 22, color: Color(0xfffe8f00)),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           if (gameEnded)
// //             Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Container(
// //                   margin: EdgeInsets.all(15),
// //                   decoration: BoxDecoration(
// //                     color: Color(0xffffd25e),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: const Color.fromARGB(255, 231, 153, 52)
// //                             .withOpacity(0.5),
// //                         spreadRadius: 5,
// //                         blurRadius: 5,
// //                         offset: Offset(0, 3),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(10),
// //                     child: Text(
// //                       endGameMessage,
// //                       textAlign: TextAlign.center,
// //                       style: const TextStyle(fontSize: 22),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     elevation: 10,
// //                     backgroundColor: Colors.green,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 20, vertical: 15),
// //                   ),
// //                   onPressed: () {
// //                     disposeSound();
// //                     Navigator.pushNamed(
// //                       context,
// //                       '/pie_chartscreen',
// //                     );
// //                   },
// //                   child: Text('Go back to your cell',
// //                       style: TextStyle(fontSize: 18, color: Colors.white)),
// //                 ),
// //               ],
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // import 'dart:math';
// // // import 'package:connections/4_dnaGame_files/bases_buttons.dart';
// // // import 'package:connections/8_user_simple_preferences.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:connections/4_dnaGame_files/nitrogenous_base.dart';
// // // import 'package:assets_audio_player/assets_audio_player.dart';

// // // class MyDNAGameScreen extends StatefulWidget {
// // //   const MyDNAGameScreen({super.key});

// // //   @override
// // //   State<MyDNAGameScreen> createState() => _MyDNAGameScreenState();
// // // }

// // // class _MyDNAGameScreenState extends State<MyDNAGameScreen> {
// // //   int answerItem = 0;
// // //   List<NitrogenousBase> dnaStrand = [];
// // //   int score = 0; //IN SHARED PREF
// // //   bool gameStarted = false;
// // //   bool startButtonVisible = true;
// // //   String feedbackText = "";
// // //   bool showFeedback = false;
// // //   String endGameMessage = "";
// // //   bool gameEnded = false;
// // //   int incorrectBases = 0;
// // //   int failedGame =
// // //       0; //IN SHARED PREF; 0 = perfect; 1 = minor mutation; 2 = major mutation
// // //   int overallScore = 0;
// // //   int accuracyRate = 0;
// // //   int baseLength = 30;
// // //   // int rate_add = UserSimplePreferences.getdnaRateAdd();
// // //   int netAccuracy = UserSimplePreferences.getdnaAccuracy();
// // //   final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
// // //   final AssetsAudioPlayer _audioPlayer1 = AssetsAudioPlayer();

// // //   final ScrollController _scrollController1 = ScrollController();
// // //   int speedControl = 40;

// // // //  @override
// // // //   void deactivate() {
// // // //     super.deactivate();
// // // //     _audioPlayer.stop(); // Stop the sound when the screen is not active.
// // // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     super.dispose();
// // //     _audioPlayer.dispose();
// // //     _audioPlayer1.dispose();
// // //   }

// // //   void disposeSound() {
// // //     _audioPlayer.dispose(); // Dispose of audio player
// // //   }

// // //   void playSound() {
// // //     _audioPlayer.open(
// // //       Audio('assets/dna_bgmusic.mp3'),
// // //       autoStart: true,
// // //       loopMode: LoopMode.single,
// // //     );
// // //     _audioPlayer.setVolume(0.2);
// // //   }

// // //   void playRightfx(){
// // //     _audioPlayer1.open(
// // //       Audio('assets/right.mp3'),
// // //       autoStart: true,
// // //       loopMode: LoopMode.single,
// // //     );
// // //   }

// // //     void playWrongfx(){
// // //     _audioPlayer1.open(
// // //       Audio('assets/wrong.mp3'),
// // //       autoStart: true,
// // //       loopMode: LoopMode.single,
// // //     );
// // //   }

// // //   void disposeSoundEffects() {
// // //     _audioPlayer1.dispose(); // Dispose of audio player
// // //   }

// // //   void startGame() {
// // //     setState(() {
// // //       playSound();
// // //       gameStarted = true;
// // //       startButtonVisible = false;
// // //       createDNAstrand();
// // //       gameEnded = false;
// // //       endGameMessage = "";
// // //       incorrectBases = 0;
// // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // //         double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
// // //         animateToMaxMin(maxScrollExtent1, 0, maxScrollExtent1, speedControl,
// // //             _scrollController1);
// // //       });
// // //     });
// // //   }

// // //   void animateToMaxMin(double max, double min, double direction, int seconds,
// // //       ScrollController scrollController) {
// // //     scrollController.animateTo(direction,
// // //         duration: Duration(seconds: seconds), curve: Curves.linear);
// // //   }

// // //   void createDNAstrand() {
// // //     setState(() {
// // //       dnaStrand.clear();
// // //       for (int i = 0; i < baseLength; i++) {
// // //         final randomNumber = Random().nextInt(4);
// // //         String nucleotide = "";
// // //         switch (randomNumber) {
// // //           case 0:
// // //             nucleotide = "A";
// // //             break;
// // //           case 1:
// // //             nucleotide = "T";
// // //             break;
// // //           case 2:
// // //             nucleotide = "C";
// // //             break;
// // //           case 3:
// // //             nucleotide = "G";
// // //             break;
// // //         }
// // //         dnaStrand.add(NitrogenousBase(baseType: nucleotide, baseChosen: ""));
// // //       }
// // //       answerItem = 0;
// // //       score = 0;
// // //     });
// // //   }

// // //   Future<void> adenine() async {
// // //     _updateBaseAtIndex(answerItem, "A");
// // //   }

// // //   Future<void> thymine() async {
// // //     _updateBaseAtIndex(answerItem, "T");
// // //   }

// // //   Future<void> guanine() async {
// // //     _updateBaseAtIndex(answerItem, "G");
// // //   }

// // //   Future<void> cytosine() async {
// // //     _updateBaseAtIndex(answerItem, "C");
// // //   }

// // //   void _updateBaseAtIndex(int index, String base) async {
// // //     if (index >= 0 && index < dnaStrand.length) {
// // //       String correctBase = "";
// // //       switch (dnaStrand[index].baseType) {
// // //         case "A":
// // //           correctBase = "T";
// // //           break;
// // //         case "T":
// // //           correctBase = "A";
// // //           break;
// // //         case "C":
// // //           correctBase = "G";
// // //           break;
// // //         case "G":
// // //           correctBase = "C";
// // //           break;
// // //       }

// // //       List<NitrogenousBase> newDnaStrand = List.from(dnaStrand);
// // //       newDnaStrand[index] = NitrogenousBase(
// // //         baseType: dnaStrand[index].baseType,
// // //         baseChosen: base,
// // //       );
// // //       setState(() {
// // //         dnaStrand = newDnaStrand;
// // //         if (base == correctBase) {
// // //           score += 100;
// // //           feedbackText = "You're right! ❤️";
// // //           playRightfx();
// // //           Future.delayed(Duration(milliseconds: 10));
// // //           disposeSoundEffects();
// // //         } else {
// // //           score -= 50;
// // //           feedbackText = "Incorrect ❌";
// // //           playWrongfx();
// // //           incorrectBases++;
// // //           Future.delayed(Duration(milliseconds: 10));
// // //           disposeSoundEffects();
// // //         }
// // //         showFeedback = true;
// // //         Future.delayed(const Duration(seconds: 1), () {
// // //           setState(() {
// // //             showFeedback = false;
// // //           });
// // //         });

// // //         answerItem++;
// // //         if (answerItem >= dnaStrand.length - (dnaStrand.length/5)) {
// // //           speedControl = 35;
// // //         }
// // //         else if (answerItem >= dnaStrand.length - (dnaStrand.length/4)){
// // //           speedControl = 30;
// // //         }
// // //         else if (answerItem >= dnaStrand.length - (dnaStrand.length/3)){
// // //           speedControl = 28;
// // //         }
// // //         else if (answerItem >= dnaStrand.length - (dnaStrand.length/2)){
// // //           speedControl = 25;
// // //         }
// // //         else if (answerItem >= dnaStrand.length) {
// // //           answerItem = dnaStrand.length - 1;
// // //           gameEnded = true;
// // //           UserSimplePreferences.setdnaScore(score);
// // //           overallScore = UserSimplePreferences.getTotalScore() +
// // //               UserSimplePreferences.getdnaScore();
// // //           UserSimplePreferences.setTotalScore(overallScore);
// // //           if (incorrectBases > 5) {
// // //             endGameMessage =
// // //                 "You might've just caused a mutation in this amoeba. You got $incorrectBases incorrect nitrogen bases.🧬⚠️";
// // //             failedGame = 2;
// // //           } else if (incorrectBases <= 5 && incorrectBases > 1) {
// // //             endGameMessage =
// // //                 "You got $incorrectBases incorrect nitrogen bases. Just a few proofreading with DNA polymerase!🧬🚨";
// // //             failedGame = Random().nextInt(2) + 1;
// // //           } else if (incorrectBases == 1) {
// // //             endGameMessage = "So close! Only 1 incorrect base.🧬";
// // //             failedGame = 1;
// // //           } else {
// // //             endGameMessage =
// // //                 "Wow, you've perfectly replicated the amoeba's DNA!🧬✨";
// // //             failedGame = 0;
// // //           }

// // //           WidgetsBinding.instance.addPostFrameCallback((_) {
// // //             _scrollController1.animateTo(
// // //               _scrollController1.position.minScrollExtent,
// // //               duration: const Duration(milliseconds: 500),
// // //               curve: Curves.easeInOut,
// // //             );
// // //           });
// // //         }
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           Column(
// // //             children: [
// // //               SizedBox(height: 30),
// // //               Container(
// // //                 decoration: BoxDecoration(
// // //                   border: Border.all(width: 1.5, color: Colors.black),
// // //                 ),
// // //                 width: 300,
// // //                 alignment: Alignment.topRight,
// // //                 child: Text(
// // //                   "Score: $score",
// // //                   style: const TextStyle(
// // //                     fontSize: 20,
// // //                     color: Colors.black,
// // //                   ),
// // //                 ),
// // //               ),
// // //               SizedBox(height: 15),
// // //               Expanded(
// // //                 flex: 4,
// // //                 child: Container(
// // //                   color: Color(0xfffff9f3),
// // //                   child: Stack(
// // //                     children: [
// // //                       Center(
// // //                         child: gameStarted
// // //                             ? Container(
// // //                                 alignment: const Alignment(0, 0.5),
// // //                                 height: 500,
// // //                                 child: ListView.builder(
// // //                                   controller: _scrollController1,
// // //                                   scrollDirection: Axis.horizontal,
// // //                                   itemCount: dnaStrand.length,
// // //                                   itemBuilder: (context, index) {
// // //                                     if (index == 0 && !gameEnded) {
// // //                                       return Padding(
// // //                                         padding: const EdgeInsets.only(
// // //                                             left: 100.0), // Adjust as needed
// // //                                         child: dnaStrand[index],
// // //                                       );
// // //                                     } else {
// // //                                       return dnaStrand[index];
// // //                                     }
// // //                                   },
// // //                                 ),
// // //                               )
// // //                             : const Center(
// // //                                 child: Text(
// // //                                   "Are you ready to replicate some DNA? \n",
// // //                                   textAlign: TextAlign.center,
// // //                                   style: TextStyle(
// // //                                       fontSize: 22,
// // //                                       fontWeight: FontWeight.w400),
// // //                                 ),
// // //                               ),
// // //                       ),
// // //                       if (gameStarted) // Show black strips only when game is started
// // //                         Container(
// // //                           alignment: const Alignment(0, 0.554),
// // //                           child: Container(
// // //                             width: 700,
// // //                             height: 30,
// // //                             decoration: BoxDecoration(
// // //                               color: Color(0xfffe8f00),
// // //                               border:
// // //                                   Border.all(width: 1.2, color: Colors.black),
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       if (gameStarted) // Show black strips only when game is started
// // //                         Container(
// // //                           alignment: const Alignment(0, -0.72),
// // //                           child: Container(
// // //                             width: 700,
// // //                             height: 30,
// // //                             decoration: BoxDecoration(
// // //                               color: Color(0xfffe8f00),
// // //                               border:
// // //                                   Border.all(width: 1.2, color: Colors.black),
// // //                             ),
// // //                           ),
// // //                         ),
// // //                        Positioned.fill(
// // //                         child: Image.asset(
// // //                           'assets/stack_cover.png', // Replace with your image path
// // //                           fit: BoxFit.cover, // Or BoxFit.fill
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //               Expanded(
// // //                 child: Container(
// // //                   color: Color(0xfffff78b),
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                     children: [
// // //                       MyButton(
// // //                         letter: "A",
// // //                         function: adenine,
// // //                         color: Color(0xffc660e8),
// // //                       ),
// // //                       MyButton(
// // //                         letter: "T",
// // //                         function: thymine,
// // //                         color: Color(0xffffda55),
// // //                       ),
// // //                       MyButton(
// // //                         letter: "C",
// // //                         function: cytosine,
// // //                         color: Color(0xffffb7b7),
// // //                       ),
// // //                       MyButton(
// // //                         letter: "G",
// // //                         function: guanine,
// // //                         color: Color(0xffa7d648),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           Center(
// // //             child: startButtonVisible
// // //                 ? ElevatedButton(
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.green,
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(20),
// // //                       ),
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 20, vertical: 15),
// // //                     ),
// // //                     onPressed: startGame,
// // //                     child: Text('START GAME',
// // //                         style: TextStyle(fontSize: 18, color: Colors.white)),
// // //                   )
// // //                 : Container(),
// // //           ),
// // //           if (showFeedback)
// // //             AnimatedOpacity(
// // //               opacity: showFeedback ? 1.0 : 0.0,
// // //               duration: const Duration(milliseconds: 500),
// // //               child: Center(
// // //                 child: Container(
// // //                   margin: const EdgeInsets.only(top: 400),
// // //                   child: Text(
// // //                     feedbackText,
// // //                     style:
// // //                         const TextStyle(fontSize: 22, color: Color(0xfffe8f00)),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           if (gameEnded)
// // //             Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 Container(
// // //                   margin: EdgeInsets.all(15),
// // //                   decoration: BoxDecoration(
// // //                     color: Color(0xffffd25e),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: const Color.fromARGB(255, 231, 153, 52)
// // //                             .withOpacity(0.5), // Shadow color with 50% opacity
// // //                         spreadRadius: 5,
// // //                         blurRadius: 5,
// // //                         offset: Offset(0, 3), // changes position of shadow
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(10),
// // //                     child: Text(
// // //                       endGameMessage,
// // //                       textAlign: TextAlign.center,
// // //                       style: const TextStyle(fontSize: 22),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: 20),
// // //                 ElevatedButton(
// // //                   style: ElevatedButton.styleFrom(
// // //                     elevation: 10,
// // //                     backgroundColor: Colors.green,
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(20),
// // //                     ),
// // //                     padding: const EdgeInsets.symmetric(
// // //                         horizontal: 20, vertical: 15),
// // //                   ),
// // //                   onPressed: () {
// // //                     disposeSound();
// // //                     Navigator.pushNamed(
// // //                       context,
// // //                       '/pie_chartscreen',
// // //                     );
// // //                     //FUNCTION THAT SETS THE ACCURACY RATE
// // //                     if (score == 3000) {
// // //                       netAccuracy = netAccuracy + 1;
// // //                       UserSimplePreferences.setdnaAccuracy(netAccuracy);
// // //                     }
// // //                   },
// // //                   child: Text('Go back to your cell',
// // //                       style: TextStyle(fontSize: 18, color: Colors.white)),
// // //                 ),
// // //               ],
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
