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
  int cellSize = 30;
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

    if (pieIndex == 2) {
      progressMsg = "Your cell has successfully grown!";
    } else if (pieIndex == 3) {
      progressMsg = "DNA Replication - Complete!";
    } else if (pieIndex == 4) {
      progressMsg = "Your cell has grown further, and ready to divide.";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/thirdscreen');
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
        backgroundColor: Color(0xffffa32c),
        title: Text('The Cell Life Cycle'),
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
            color: Colors.yellow
                .withOpacity(0.5), // Optional overlay for better contrast
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Cell's Score: ${UserSimplePreferences.getTotalScore()}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 600,
                        height: 500,
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
                                          cellSize = 150;
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
                                          cellSize = 200;
                                          break;
                                        case 4:
                                          _playButtonClickSound();
                                          final result =
                                              await Navigator.pushNamed(context,
                                                  '/mitosis_quizscreen');

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

                    cellDivideButtonShow
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
                            },
                            child: Text('Divide your cell!', style: TextStyle(fontSize: 18, color: Colors.white)),
                          )
                        : Container(
                            margin: EdgeInsets.all(8),
                            constraints: BoxConstraints(
                                minHeight: 100), // Ensure minimum height

                            child: Text(
                              progressMsg,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),

                    //the CELL----------------------------------------
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
