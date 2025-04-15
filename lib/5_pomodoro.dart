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
  static const int workTime = 1500; // 1500 seconds = 25 mins
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
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: workTime));
  }

  @override
  void dispose() {
    _controller.dispose();
    _assetsAudioPlayer.dispose(); // Dispose of audio player
    super.dispose();
  }

  void playSound() {
    _assetsAudioPlayer.open(
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
          //Play the times up sound effect
          _assetsAudioPlayer.open(
            Audio('assets/timesup.mp3'),
          );

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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NextPage(final_pomodoro_score: final_pomodoro_score)),
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
        title: Text(
          'Pomodoro Timer',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'PressStart2P',
            color:  const Color.fromARGB(255, 255, 119, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xffffda55),
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
                  Text(
                    isWorkTime ? 'Pomodoro \nTimer' : 'Time\'s Up!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 119, 0),
                      fontSize: 28,
                      fontFamily: 'PressStart2P',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 48,
                      fontFamily: 'PressStart2P', // Custom font applied
                    ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          startTimer();
                          playSound(); // Play sound effect
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          resetTimer();
                          playSound(); // Play sound effect
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontFamily: 'PressStart2P', // Custom font applied
                          ),
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
        title: Text(
          'Time\'s Up!',
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 255, 119, 0),
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Time\'s Up! \nYou gain $final_pomodoro_score points!',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 119, 0),
                        fontSize: 23,
                        fontFamily: 'PressStart2P', // Custom font applied
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pie_chartscreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'PressStart2P', // Custom font applied
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
