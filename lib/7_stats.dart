import 'package:connections/8_user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyStatsPage extends StatefulWidget {
  MyStatsPage({super.key});

  @override
  State<MyStatsPage> createState() => _MyStatsPageState();
}

class _MyStatsPageState extends State<MyStatsPage> {
  late Future<void> _prefsInit;

  @override
  void initState() {
    super.initState();
    _prefsInit = UserSimplePreferences.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Game Statistics',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'PressStart2P',
            color: const Color.fromARGB(255, 255, 154, 22),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xffffda55),
      ),
      body: Container(
        // Replace the yellow background with an image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homescreen_bg.png'),
            fit: BoxFit.cover, // Adjusts the image to fill the screen
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green
                    .withOpacity(0.8), // Add transparency for better contrast
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'OVERALL SCORE: \n${UserSimplePreferences.getTotalScore()}',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 224, 255, 214),
                  fontFamily: 'PressStart2P', // Apply custom font
                ),
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder(
              future: _prefsInit,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // SharedPreferences is initialized, build the chart
                  final List<Statistic> statistics = [
                    Statistic('Pomodoro \nSession Completed',
                        UserSimplePreferences.getTotalPomodoroSessions()),
                    Statistic('Total Cells Formed',
                        UserSimplePreferences.getCellNumber()),
                    Statistic('Perfect Quiz Scores',
                        UserSimplePreferences.getQuizAccuracy()),
                    Statistic('Perfect \nDNA Replications',
                        UserSimplePreferences.getdnaAccuracy()),
                    Statistic('Total Focus Time \n(minutes)',
                        UserSimplePreferences.getTotalFocusTime()),
                  ];

                  return Container(
                    color: Colors
                        .transparent, // Maintain transparent background for image
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            'Statistics',
                            style: TextStyle(
                              fontSize: 24,
                              color:  const Color.fromARGB(255, 255, 119, 0),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 300,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: <CartesianSeries>[
                                  BarSeries<Statistic, String>(
                                    dataSource: statistics,
                                    xValueMapper: (Statistic statistic, _) =>
                                        statistic.category,
                                    yValueMapper: (Statistic statistic, _) =>
                                        statistic.value,
                                    color: Colors.orange,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(color: Colors.orange,
                                        fontSize: 12,
                                        fontFamily: 'PressStart2P',
              
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/thirdscreen');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 224, 255, 214),
                                fontFamily: 'PressStart2P',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/gamescreen');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              'About',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 224, 255, 214),
                                fontFamily: 'PressStart2P',
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Statistic {
  final String category;
  final int value;

  Statistic(this.category, this.value);
}
