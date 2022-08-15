class Question {
  String statement;
  bool isCorrect;

  Question(this.statement, this.isCorrect);
}

class Quiz {
  int currQuestionNum = 0;
  int correctCnt = 0;
  bool isEndQuiz = false;
  List<Question> questions = [];

  Quiz(this.questions);

  void nextQuestion() {
    currQuestionNum++;
  }

  bool check(bool isCorrect) {
    if (questions[currQuestionNum].isCorrect == isCorrect) {
      correctCnt++;
      return true;
    }

    return false;
  }

  bool isLastQuestion() {
    return currQuestionNum == questions.length - 1;
  }

  String getQuestionStmt() {
    return questions[currQuestionNum].statement;
  }

  double getCorrectRate() {
    return correctCnt / questions.length;
  }

  void resetQuiz() {
    currQuestionNum = 0;
    correctCnt = 0;
  }
}
