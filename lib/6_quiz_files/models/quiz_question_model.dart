class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.correctAnswer);

  final String text;
  final List<String> answers;
   final String correctAnswer; // Store the correct answer explicitly

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}