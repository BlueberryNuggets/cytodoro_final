import 'package:connections/8_user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:connections/6_quiz_files/questions_summary.dart';
import 'package:connections/6_quiz_files/models/quiz_question_model.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.currentQuestionSet,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;
  final List<QuizQuestion> currentQuestionSet;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': currentQuestionSet[i].text,
          'correct_answer': currentQuestionSet[i].correctAnswer,
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int score = 0;
  int overallScore = 0;
  int accuracyRate = 0;
  // int rateAdd = UserSimplePreferences.getquizRateAdd();
  int netAccuracy = UserSimplePreferences.getQuizAccuracy();
  // int timePenalty = 0;
  // int timeElapsed = 0; // Add timeElapsed variable

  @override
  void initState() {
    super.initState();
    calculateScore();
  }

  void calculateScore() {
    final summaryData = widget.getSummaryData();

    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'].toString().toLowerCase() ==
          data['correct_answer'].toString().toLowerCase();
    }).length;

    score = numCorrectQuestions * 100;

    // // Example time elapsed (replace with actual time tracking)
    // timeElapsed = 10; // 10 seconds elapsed, for example.
    // timePenalty = timeElapsed * 270;

    // score -= timePenalty;

    if (score < 0) {
      score = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = widget.getSummaryData();
    final numTotalQuestions = widget.currentQuestionSet.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'].toString().toLowerCase() ==
          data['correct_answer'].toString().toLowerCase();
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          height: 700,
          margin: const EdgeInsets.all(40),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 6,
                  blurRadius: 5,
                  offset: Offset(4, 7),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffffde59),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(3),
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "RESULTS SCREEN",
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xfffe8f00),
                        letterSpacing: 6,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                    alignment: Alignment.center,
                    color: Color(0xfffff78b),
                    child: QuestionsSummary(summaryData)),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: const Text(
                      'Finish Review',
                      style: TextStyle(
                        color: const Color(0xfffe8f00),
                      ),
                    ),
                  onPressed: () {
                    widget.onRestart();
                    UserSimplePreferences.setQuizScore(score);
                    overallScore = UserSimplePreferences.getTotalScore() +
                        UserSimplePreferences.getQuizScore();
                    UserSimplePreferences.setTotalScore(overallScore);

                    //UPDATING THE QUIZ ACCURACY RATE
                    if (score == 500) {
                      netAccuracy = netAccuracy + 1;
                      UserSimplePreferences.setQuizAccuracy(netAccuracy);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
