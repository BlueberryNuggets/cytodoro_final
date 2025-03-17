import 'package:connections/1.0_real_startscreen.dart';
import 'package:connections/2.0_gamescreen.dart';
import 'package:connections/2.1_thirdscreen.dart';
import 'package:connections/3_piechart.dart';
import 'package:connections/4.0_dnaGame_loadingScreen.dart';
import 'package:connections/4_dnaGame.dart';
import 'package:connections/6.0_quizLoadingScreen.dart';
import 'package:connections/6_quiz.dart';
import 'package:connections/7_stats.dart';
import 'package:connections/8_user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:connections/5_pomodoro.dart';
import 'package:flutter/services.dart'; // Import SystemNavigator

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => PieChartState(),
      child: const MyApp(),
    ),
  );
}

Widget wrapWithPopScope(Widget child) {
  return PopScope(
    canPop: false,
    onPopInvoked: (didPop) {
      if (didPop) {
        return;
      }
      SystemNavigator.pop();
    },
    child: child,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    UserSimplePreferences.setCellNumber(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cytodoro Game',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: wrapWithPopScope(HomeScreen()),
      routes: {
        '/homescreen': (context) => wrapWithPopScope(HomeScreen()),
        '/gamescreen': (context) => wrapWithPopScope(GameScreen()),
        '/thirdscreen': (context) => wrapWithPopScope(ThirdScreen()),
        '/pie_chartscreen': (context) => wrapWithPopScope(MyPieChartScreen()),
        '/pomodoro_timer': (context) => wrapWithPopScope(PomodoroTimer()),
        '/dna_loadingscreen': (context) => wrapWithPopScope(DnaAnimationSequence()),
        '/dna_gamescreen': (context) => wrapWithPopScope(MyDNAGameScreen()),
        'quiz_loadingscreen': (context) => wrapWithPopScope(QuizIntroScreen()),
        '/mitosis_quizscreen': (context) => wrapWithPopScope(Quiz()),
        '/stats_page': (context) => wrapWithPopScope(MyStatsPage()),
      },
    );
  }
}

// import 'package:connections/1.0_real_startscreen.dart';
// import 'package:connections/2.0_gamescreen.dart';
// import 'package:connections/2.1_thirdscreen.dart';
// import 'package:connections/3_piechart.dart';
// import 'package:connections/4.0_dnaGame_loadingScreen.dart';
// import 'package:connections/4_dnaGame.dart';
// import 'package:connections/6.0_quizLoadingScreen.dart';
// import 'package:connections/6_quiz.dart';
// import 'package:connections/7_stats.dart';
// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:connections/5_pomodoro.dart';
// import 'package:flutter/services.dart'; // Import SystemNavigator

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await UserSimplePreferences.init();

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => PieChartState(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     UserSimplePreferences.setCellNumber(1);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Cytodoro Game',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       home: PopScope(
//         canPop: false,
//         onPopInvoked: (didPop) {
//           if (didPop) {
//             return;
//           }
//           SystemNavigator.pop(); // Exit the app
//         },
//         child: HomeScreen(),
//       ),
//       routes: {
//         '/homescreen': (context) => HomeScreen(),
//         '/gamescreen': (context) => GameScreen(),
//         '/thirdscreen': (context) => ThirdScreen(),
//         '/pie_chartscreen': (context) => MyPieChartScreen(),
//         '/pomodoro_timer': (context) => PomodoroTimer(),
//         '/dna_loadingscreen': (context) => DnaAnimationSequence(),
//         '/dna_gamescreen': (context) => MyDNAGameScreen(),
//         'quiz_loadingscreen': (context) => QuizIntroScreen(),
//         '/mitosis_quizscreen': (context) => Quiz(),
//         '/stats_page': (context) => MyStatsPage(),
//       },
//     );
//   }
// }

// import 'package:connections/1.0_real_startscreen.dart';
// import 'package:connections/2.0_gamescreen.dart';
// import 'package:connections/2.1_thirdscreen.dart';
// import 'package:connections/3_piechart.dart';
// import 'package:connections/4.0_dnaGame_loadingScreen.dart';
// import 'package:connections/4_dnaGame.dart';
// import 'package:connections/6.0_quizLoadingScreen.dart';
// import 'package:connections/6_quiz.dart';
// import 'package:connections/7_stats.dart';
// import 'package:connections/8_user_simple_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:connections/5_pomodoro.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await UserSimplePreferences.init(); 
//   UserSimplePreferences.clearPrefs();

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => PieChartState(),
//       child: const MyApp(),
//     ),
//   );
// }

// // @override
// // void initilize(){
// //   UserSimplePreferences.setCellNumber(1);
// //   UserSimplePreferences.setCytodoroSessions(0);
// //   UserSimplePreferences.setPieIndex(0);
// //   UserSimplePreferences.setPomodoroScore1(0);
// //   UserSimplePreferences.setPomodoroScore2(0);
// //   UserSimplePreferences.setQuizAccuracy(0);
// //   UserSimplePreferences.setQuizScore(0);
// //   UserSimplePreferences.setTotalFocusTime(0);
// //   UserSimplePreferences.setTotalPomodoroSessions(0); 
// //   UserSimplePreferences.setTotalScore(0);
// //   UserSimplePreferences.setdnaAccuracy(0);
// //   // UserSimplePreferences.setdnaRateAdd(0); 
// //   UserSimplePreferences.setdnaScore(0); 
// //   UserSimplePreferences.setquizRateAdd(0);
// // }
// //MY APP ___________________________________
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // SharedPreferences? _prefs;
//   // int _totalScore = 0;

//   // @override
//   // void initState(){
//   //   super.initState();
//   //   _initPrefs();
//   // }

//   // void _initPrefs() async {
//   //   _prefs = await SharedPreferences.getInstance();
//   //   _setPrefs();
//   // }

//   // void _setPrefs() {
//   //   _prefs?.setInt('totalScore', 255555);
//   //   print('setPrefs method called');
//   // }

//   // void getPrefs() {
//   //   _totalScore = _prefs?.getInt('totalScore') ?? 0;
//   //   print('getPrefs method called');
//   // }
//   @override
//   void initState() {
//     UserSimplePreferences.setCellNumber(1);
//     super.initState();
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Cytodoro Game',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       home: PopScope(
//         canPop: false, // Prevent default back behavior
//         onPopInvoked: (didPop) {
//           if (didPop) {
//             return; // If the system already handled the pop, do nothing
//           }
//           // Navigate to the homescreen and remove all other routes
//           Navigator.pushNamedAndRemoveUntil(context, '/homescreen', (route) => false);
//         },
//         child: HomeScreen(), // Your homescreen widget
//       ),
//       routes: {
//         '/homescreen': (context) => HomeScreen(),
//         '/gamescreen' : (context) => GameScreen(),
//         '/thirdscreen' : (context) => ThirdScreen(),
//         '/pie_chartscreen': (context) => MyPieChartScreen(),
//         '/pomodoro_timer' : (context) => PomodoroTimer(),
//         '/dna_loadingscreen': (context) => DnaAnimationSequence(),
//         '/dna_gamescreen': (context) => MyDNAGameScreen(),
//         'quiz_loadingscreen' : (context) => QuizIntroScreen(),
//         '/mitosis_quizscreen': (context) => Quiz(), 
//         '/stats_page' : (context) => MyStatsPage(),
//       },
//     );
//   }
// }