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
        title: Text('Game Statistics'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('OVERALL SCORE: ${UserSimplePreferences.getTotalScore()}', style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          FutureBuilder(
            future: _prefsInit,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // SharedPreferences is initialized, build the chart
                final List<Statistic> statistics = [
                  Statistic('Pomodoro Session Completed',
                      UserSimplePreferences.getTotalPomodoroSessions()),
                  Statistic('Cells Formed',
                      UserSimplePreferences.getCytodoroSessions()),
                  Statistic('Quiz Accuracy Rate',
                      UserSimplePreferences.getQuizAccuracy()),
                  Statistic('DNA Replication Accuracy Rate',
                      UserSimplePreferences.getdnaAccuracy()),
                  Statistic('Total Focus Time',
                      UserSimplePreferences.getTotalFocusTime()),
                ];

                return Container(
                  color: Colors.yellowAccent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          'Statistics',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
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
                                  isVisible: true, // Enable data labels
                                  textStyle: TextStyle(fontSize: 12), // Customize label style
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/thirdscreen');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text('Home', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/gamescreen');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text('About', style: TextStyle(color: Colors.white)),
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
    );
  }
}

class Statistic {
  final String category;
  final int value;

  Statistic(this.category, this.value);
}

// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class MyStatsPage extends StatefulWidget {
//   MyStatsPage({super.key});

//   @override
//   State<MyStatsPage> createState() => _MyStatsPageState();
// }

// class _MyStatsPageState extends State<MyStatsPage> {
//   late Future<void> _prefsInit; // Store the Future from init()

//   @override
//   void initState() {
//     super.initState();
//     _prefsInit = UserSimplePreferences.init(); // Initialize SharedPreferences
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Statistics'),
//       ),
//       body: FutureBuilder(
//         future: _prefsInit,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // SharedPreferences is initialized, build the chart
//             final List<Statistic> statistics = [
//               Statistic('Cytodoro Session Completed', UserSimplePreferences.getCytodoroSessions()),
//               Statistic('Cells Formed', UserSimplePreferences.getCellNumber()),
//               Statistic('Quiz Accuracy Rate', UserSimplePreferences.getQuizAccuracy()),
//               Statistic('DNA Replication Accuracy Rate', UserSimplePreferences.getdnaAccuracy()),
//               Statistic('Total Focus Time', UserSimplePreferences.getTotalFocusTime()),
//             ];

//             return Container(
//               color: Colors.yellowAccent,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(height: 20),
//                     Text(
//                       'Statistics',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Expanded(
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         series: <CartesianSeries>[
//                           BarSeries<Statistic, String>(
//                             dataSource: statistics,
//                             xValueMapper: (Statistic statistic, _) => statistic.category,
//                             yValueMapper: (Statistic statistic, _) => statistic.value,
//                             color: Colors.orange,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                       child: Text('Home'),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                       child: Text('Play Again'),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             // SharedPreferences is still initializing, show a loading indicator
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class Statistic {
//   final String category;
//   final int value;

//   Statistic(this.category, this.value);
// }
