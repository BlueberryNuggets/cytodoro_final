import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  int final_pomodoro_score = 0;
  int pomodoro_counter = UserSimplePreferences.getPieIndex();
  int overallScore = UserSimplePreferences.getTotalScore();
  int total_focus_sessions = UserSimplePreferences.getTotalPomodoroSessions();
  int total_focus_time = UserSimplePreferences.getTotalFocusTime();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer(); // Initialize audio player

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: workTime));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose(); // Dispose of audio player
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
    playSound(); // Play sound effect
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
          _controller.value = 1.0; // Finish the animation
          //FOCUS SESSION & TIME COUNT
          total_focus_sessions = total_focus_sessions + 1;
          UserSimplePreferences.setTotalPomodoroSessions(total_focus_sessions);
          total_focus_time = total_focus_sessions * 25;
          UserSimplePreferences.setTotalFocusTime(total_focus_time);

          //FUNCTION STUFF FOR SCORE MANAGEMENT
          score = score + 10000;
          if (pomodoro_counter == 1) {
            UserSimplePreferences.setPomodoroScore1(score);
            UserSimplePreferences.setPomodoroScore2(0);
            final_pomodoro_score = UserSimplePreferences.getPomodoroScore1();
            overallScore = overallScore + final_pomodoro_score;
            UserSimplePreferences.setTotalScore(overallScore);
          } else if (pomodoro_counter == 3) {
            UserSimplePreferences.setPomodoroScore1(0);
            UserSimplePreferences.setPomodoroScore2(score);
            final_pomodoro_score = UserSimplePreferences.getPomodoroScore2();
            overallScore = overallScore + final_pomodoro_score;
            UserSimplePreferences.setTotalScore(overallScore);
          }

          print(score);

          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(final_pomodoro_score: final_pomodoro_score)),
            ); //NEXT PAGE IS WITHIN THE SAME FILE!
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
      playSound(); // Play sound effect
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
      remainingTime = isWorkTime ? workTime : breakTime;
      _controller.reset();
      playSound(); // Play sound effect
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Pomodoro Timer'),
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
                  Lottie.asset(
                    'assets/amoeba_growing.json',
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller.duration = Duration(
                          seconds: workTime); // Set duration to work time
                    },
                  ), // Lottie animation
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      isWorkTime ? 'Pomodoro Timer' : 'Time\'s Up!',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  Text(
                    '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          stopTimer();
                          playSound(); // Play sound effect
                        },
                        child: Text('Stop'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          startTimer();
                          playSound(); // Play sound effect
                        },
                        child: Text('Start'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          resetTimer();
                          playSound(); // Play sound effect
                        },
                        child: Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Background color
                          foregroundColor: Colors.white, // Text color
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
  final int final_pomodoro_score;
  const NextPage({required this.final_pomodoro_score, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Time\'s Up!'),
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
                  Container(
                    width: 400, // Set the desired width
                    height: 400, // Set the desired height
                    child: Lottie.asset(
                      'assets/amoeba_wiggle.json',
                      repeat: true, // Make the animation loop
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Time\'s Up! \nYou gain $final_pomodoro_score points!',
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pie_chartscreen');
                    },
                    child: Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                      foregroundColor: Colors.white, // Text color
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
