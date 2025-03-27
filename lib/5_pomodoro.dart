import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:connections/8_user_simple_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer>
    with SingleTickerProviderStateMixin {
  static const int workTime = 5; // 10 seconds
  static const int breakTime = 0; // 0 seconds
  int remainingTime = workTime;
  bool isRunning = false;
  bool isWorkTime = true;
  Timer? timer;
  late AnimationController _controller;
  int score = 0;
  int finalPomodoroScore = 0;
  int pomodoroCounter = UserSimplePreferences.getPieIndex();
  int overallScore = UserSimplePreferences.getTotalScore();
  int totalFocusSessions = UserSimplePreferences.getTotalPomodoroSessions();
  int totalFocusTime = UserSimplePreferences.getTotalFocusTime();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: workTime));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void playSound() {
    _audioPlayer.open(
      Audio('assets/tap.mp3'),
      autoStart: true,
    );
  }

  void startTimer() {
    if (isRunning) return;
    setState(() {
      isRunning = true;
    });
    _controller.forward(from: _controller.value);
    playSound();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isWorkTime = !isWorkTime;
          remainingTime = isWorkTime ? workTime : breakTime;
          isRunning = false;
          timer.cancel();
          _controller.stop();
          _controller.value = 1.0;

          totalFocusSessions += 1;
          UserSimplePreferences.setTotalPomodoroSessions(totalFocusSessions);
          totalFocusTime = totalFocusSessions * 25;
          UserSimplePreferences.setTotalFocusTime(totalFocusTime);

          score += 10000;
          if (pomodoroCounter == 1) {
            UserSimplePreferences.setPomodoroScore1(score);
            UserSimplePreferences.setPomodoroScore2(0);
            finalPomodoroScore = UserSimplePreferences.getPomodoroScore1();
            overallScore += finalPomodoroScore;
            UserSimplePreferences.setTotalScore(overallScore);
          } else if (pomodoroCounter == 3) {
            UserSimplePreferences.setPomodoroScore1(0);
            UserSimplePreferences.setPomodoroScore2(score);
            finalPomodoroScore = UserSimplePreferences.getPomodoroScore2();
            overallScore += finalPomodoroScore;
            UserSimplePreferences.setTotalScore(overallScore);
          }

          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NextPage(finalPomodoroScore: finalPomodoroScore),
              ),
            );
          });
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
      _controller.stop();
      playSound();
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
      remainingTime = isWorkTime ? workTime : breakTime;
      _controller.reset();
      playSound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Pomodoro Timer',
          style: TextStyle(
            fontFamily: 'PressStart2P', // Custom font applied
          ),
        ),
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
            color: Colors.yellow.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/amoeba_growing.json',
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller.duration = Duration(seconds: workTime);
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    isWorkTime ? 'Pomodoro Timer' : 'Time\'s Up!',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'PressStart2P', // Custom font applied
                    ),
                  ),
                  Text(
                    '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'PressStart2P', // Custom font applied
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: stopTimer,
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: startTimer,
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: resetTimer,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
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

class NextPage extends StatelessWidget {
  final int finalPomodoroScore;
  const NextPage({required this.finalPomodoroScore, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Time\'s Up!',
          style: TextStyle(
            fontFamily: 'PressStart2P', // Custom font applied
          ),
        ),
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
            color: Colors.yellow.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: Lottie.asset(
                      'assets/amoeba_wiggle.json',
                      repeat: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Time\'s Up! \nYou gain $finalPomodoroScore points!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'PressStart2P', // Custom font applied
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pie_chartscreen');
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'PressStart2P', // Custom font applied
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
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

// class MyPomodoroTimer extends StatefulWidget {
//   const MyPomodoroTimer({super.key});

//   @override
//   _MyPomodoroTimerState createState() => _MyPomodoroTimerState();
// }

// class _MyPomodoroTimerState extends State<MyPomodoroTimer> {
//   int _totalSeconds = 1 * 1; // Store total seconds
//   Timer? _timer;
//   var f = NumberFormat("00");
//   bool _isRunning = false;
//   bool _backButtonInvisible = true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//     _isRunning = false;
//   }

//   void _resetTimer() {
//     _stopTimer();
//     _totalSeconds = 1 * 1; // Reset total seconds
//     setState(() {});
//   }

//   void _startTimer() {
//     if (_isRunning) return;

//     _isRunning = true;

//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_totalSeconds > 0) {
//           _totalSeconds--;
//         } else {
//           _timer?.cancel();
//           _isRunning = false;
//           _backButtonInvisible = false;
//           print("Timer Complete");
//         }
//       });
//     });
//   }

//   int get _minutes => _totalSeconds ~/ 60;
//   int get _seconds => _totalSeconds % 60;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "${f.format(_minutes)}:${f.format(_seconds)}",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 48,
//               ),
//             ),
//             SizedBox(height: 100),
//             _backButtonInvisible
//                 ? const Text(' ')
//                 : ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _backButtonInvisible = true;
//                         Navigator.pushNamed(context, '/pie_chartscreen');
//                       });
//                     },
//                     child: const Text('Finish the Pomodoro Session!'), // Changed to const for optimization
//                   ),//Reset Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                   ElevatedButton(
//                   onPressed: _resetTimer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     shape: CircleBorder(),
//                     padding: EdgeInsets.all(40),
//                     side: BorderSide(color: Colors.orange),
//                   ),
//                   child: Text(
//                     "Reset",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _isRunning ? null : _startTimer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         _isRunning ? Colors.grey : Colors.orange[300],
//                     shape: CircleBorder(),
//                     padding: EdgeInsets.all(40),
//                   ),
//                   child: Text(
//                     "Start",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _isRunning ? _stopTimer : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         _isRunning ? Colors.orange[300] : Colors.grey,
//                     shape: CircleBorder(),
//                     padding: EdgeInsets.all(40),
//                   ),
//                   child: Text(
//                     "Stop",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Lottie.asset('assets/amoeba_growing.json'),
//           ],
//         ),
//       ),
//     );
//   }
// }
