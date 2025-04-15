import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:connections/3_piechart_files/pie_chart.dart';
import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';
import 'package:connections/8_user_simple_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MyPieChartScreen extends StatefulWidget {
  const MyPieChartScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  _MyPieChartScreenState createState() => _MyPieChartScreenState();
}

class _MyPieChartScreenState extends State<MyPieChartScreen> {
  bool cellDivideButtonShow = false;
  int cellSize = 20;
  String progressMsg = "Start the Cell Life Cycle...";
  int overallScore = 0;
  int pieIndex = 0;
  int g1Score = 0;
  int sScore = 0;
  int g2Score = 0;
  int mScore = 0;
  int totalCytodoroSessions = 0;

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  void updateScalingStage(BuildContext context, int stage) {
    Provider.of<PieChartState>(context, listen: false)
        .updateScalingStage(stage);
  }

  void _playButtonClickSound() {
    _audioPlayer.open(
      Audio("assets/tap.mp3"),
      autoStart: true,
      showNotification: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = widget.arguments ?? {};
    pieIndex = UserSimplePreferences.getPieIndex();

    if (pieIndex == 1) {
      progressMsg = "Your cell has successfully grown!";
    } else if (pieIndex == 2) {
      progressMsg = "DNA Replication - Complete!";
    } else if (pieIndex == 3) {
      progressMsg = "Your cell has grown further, and ready to divide.";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffffa32c),
        title: Text(
          'The Cell Life Cycle',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 249, 237),
            fontSize: 18,
            letterSpacing: -1,
            wordSpacing: -10,
            fontFamily: 'PressStart2P', // Apply custom font
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/homescreen_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.yellow.withOpacity(0.5),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: 240,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Cell's Score: ${UserSimplePreferences.getTotalScore()}",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PressStart2P', // Apply custom font
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 630,
                        height: 470,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              color: Color(0xfffff9f3),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: MyPieChart(
                                  onSegmentClicked: (segment) async {
                                    int currentStage =
                                        Provider.of<PieChartState>(context,
                                                listen: false)
                                            .scalingStage;
                                    if (segment == currentStage + 1) {
                                      updateScalingStage(context, segment);
                                      switch (segment) {
                                        case 1:
                                          UserSimplePreferences.setPieIndex(1);
                                          _playButtonClickSound();
                                          Navigator.pushNamed(
                                              context, '/pomodoro_timer');
                                          cellSize = 100;
                                          break;
                                        case 2:
                                          UserSimplePreferences.setPieIndex(2);
                                          _playButtonClickSound();
                                          Navigator.pushNamed(
                                              context, '/dna_loadingscreen');
                                          g1Score = UserSimplePreferences
                                              .getPomodoroScore1();
                                          break;
                                        case 3:
                                          UserSimplePreferences.setPieIndex(3);
                                          _playButtonClickSound();
                                          Navigator.pushNamed(
                                              context, '/pomodoro_timer');
                                          cellSize = 150;
                                          break;
                                        case 4:
                                          UserSimplePreferences.setPieIndex(4);
                                          _playButtonClickSound();
                                          final result =
                                              await Navigator.pushNamed(context,
                                                  'quiz_loadingscreen');

                                          if (result != null &&
                                              result is Map<String, dynamic> &&
                                              result['quizCompleted'] == true) {
                                            setState(() {
                                              cellDivideButtonShow = true;
                                            });
                                          }
                                          break;
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    UserSimplePreferences.getPieIndex() == 4
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
                              _playButtonClickSound();
                              Provider.of<PieChartState>(context, listen: false)
                                  .reset();
                              Navigator.pushNamed(context, '/thirdscreen');
                              totalCytodoroSessions = totalCytodoroSessions + 1;
                              UserSimplePreferences.setCytodoroSessions(
                                  totalCytodoroSessions);
                              UserSimplePreferences
                                  .setHasDivideCellButtonBeenUsed(false);
                              UserSimplePreferences.setPieIndex(0);
                              // canMultiply = true;
                              // UserSimplePreferences.setMultiply(canMultiply);
                            },
                            child: Text(
                              'Go back to petri dish',
                              style: TextStyle(
                                letterSpacing: -1,
                                wordSpacing: -6,
                                fontSize: 13,
                                fontFamily: 'PressStart2P', // Apply custom font
                                color: const Color.fromARGB(255, 224, 255, 214),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(8),
                            constraints: BoxConstraints(minHeight: 100),
                            child: Text(
                              progressMsg,
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: -0.5,
                                fontFamily: 'PressStart2P', // Apply custom font
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Consumer<PieChartState>(
                          builder: (context, state, child) {
                            return AnimatedScale(
                              scale: state.scalingStage > 0 ? 1.4 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              child: LottieBuilder.asset(
                                'assets/amoeba_wiggle.json',
                                height: 200,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
