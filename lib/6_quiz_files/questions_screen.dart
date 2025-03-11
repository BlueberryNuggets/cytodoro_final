import 'package:flutter/material.dart';

import 'package:connections/6_quiz_files/answer_button.dart';
import 'package:connections/6_quiz_files/models/quiz_question_model.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key,
      required this.onSelectAnswer,
      required this.currentQuestionSet});

  final void Function(String answer) onSelectAnswer;
  final List<QuizQuestion> currentQuestionSet;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  var actualQuestionNo = 1;

  void answerQuestion(String selectedAnswers) {
    widget.onSelectAnswer(selectedAnswers);
    // currentQuestionIndex = currentQuestionIndex + 1;
    // currentQuestionIndex += 1;
    print(selectedAnswers);
    setState(() {
      currentQuestionIndex++;
      actualQuestionNo++; // increments the value by 1
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = widget
        .currentQuestionSet[currentQuestionIndex]; // Use currentQuestionSet

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          height: 600,
          margin: const EdgeInsets.all(40),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Shadow color
                  spreadRadius: 6, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(4, 7), // Offset in the x and y direction
                ),
                // You can add more BoxShadow objects here for multiple shadows
              ],
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffffde59),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.all(3),
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "QUESTION NO. $actualQuestionNo",
                    style: TextStyle(color: const Color(0xfffe8f00), letterSpacing: 6, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  currentQuestion.text,
                  style: const TextStyle(
                    color: Color(0xff432907),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...currentQuestion.getShuffledAnswers().map((answer) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AnswerButton(
                      answerText: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
