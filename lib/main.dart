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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

    @override
    void initState() {
        //clear this for the ACTUAL APP
        //UserSimplePreferences.clearPrefs();
        UserSimplePreferences.setCytodoroDone(false);
        super.initState();
        WidgetsBinding.instance.addObserver(this);
    }

    @override
    void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        super.dispose();
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
        if (state == AppLifecycleState.paused) {
            print("App paused");
        } else if (state == AppLifecycleState.resumed) {
            print("App resumed");
        }
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