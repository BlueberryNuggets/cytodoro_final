import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, this.backButtonBool, {super.key});

  final void Function() startQuiz;
  final bool backButtonBool;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/amoeba_wiggle.json', height: 280),
          Stack(
            children: [
              const Text(
                'The Amoeba Mitosis Game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff5f43b5),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: backButtonBool
                    //go back to pie chart
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context, {'quizCompleted': true});
                        },
                        child: Image.asset('assets/backtocell_button2.png', height: 320),
                      )
                    // ? OutlinedButton.icon(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/pie_chartscreen');
                    //     },
                    //     style: OutlinedButton.styleFrom(
                    //       foregroundColor: Colors.white,
                    //     ),,
                    //     icon: const Icon(Icons.arrow_right_alt),
                    //     label: const Text('Go back to your cell!'),
                
                    //start game
                    : GestureDetector(
                        onTap: startQuiz,
                        child: Image.asset(
                          'assets/startgame_button2.png',
                          height: 500,
                        ),
                      ),
              ),
            ],
          )

          // : OutlinedButton.icon(
          //     onPressed: (startQuiz),
          //     style: OutlinedButton.styleFrom(
          //       foregroundColor: Colors.white,
          //     ),
          //     icon: const Icon(Icons.arrow_right_alt),
          //     label: const Text('Start Quiz'),
          //   )
        ],
      ),
    );
  }
}
