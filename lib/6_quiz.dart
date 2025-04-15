import 'package:flutter/material.dart';
import 'package:connections/6_quiz_files/start_screen.dart';
import 'package:connections/6_quiz_files/questions_screen.dart';
import 'package:connections/6_quiz_files/results_screen.dart';
import 'package:connections/6_quiz_files/data/real_questions.dart';
import 'package:connections/6_quiz_files/models/quiz_question_model.dart';
import 'dart:math';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';
  List<QuizQuestion> currentQuestionSet =
      []; // To store the selected question set
  var currentQuestionIndex = 0;
  bool backButtonBool = false; //to determine which

  @override
  void initState() {
    super.initState();
    _selectNewQuestionSet(); // Select initial question set
  }

  void _selectNewQuestionSet() {
    final random = Random();
    final randomIndex =
        random.nextInt(questionSets.length); // Generate random index
    currentQuestionSet = questionSets[randomIndex]; // Select the question set
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == currentQuestionSet.length) {
      // Use currentQuestionSet.length {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    // New function to reset the quiz
    setState(() {
      selectedAnswers = []; // Clear selected answers
      currentQuestionIndex = 0; // Reset question index
      activeScreen = 'start-screen';
      backButtonBool =
          true; //to dictate whether to display start-button or go-back-button
      _selectNewQuestionSet(); // Select a new question set on restart
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen, backButtonBool);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
        currentQuestionSet: currentQuestionSet, // Pass the current question set
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        currentQuestionSet: currentQuestionSet, // Pass the question set HERE!
        onRestart: restartQuiz, // Pass the restartQuiz function
      );
    }

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/quiz_bg_3.png'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
          child: screenWidget,
        ),
      );
  }
}
