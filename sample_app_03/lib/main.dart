import 'package:flutter/material.dart';
import './classes/quiz.dart';
import './questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Quiz quiz = Quiz(questions);

  void checkAnswer(bool userChoiceAnswer) {
    setState(() {
      if (!quiz.isLastQuestion()) {
        bool isCorrect = quiz.check(userChoiceAnswer);
        showIsCorrectSnackBar(isCorrect);
        quiz.nextQuestion();
      } else {
        double correctRate = quiz.getCorrectRate();
        showResultDialog(correctRate);
      }
    });
  }

  void showResultDialog(double correctRate) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Finish!'),
          content: Text('Your correct rate is $correctRate'),
          actions: [
            ElevatedButton(
              child: const Text('Retry'),
              onPressed: () {
                setState(() => quiz.resetQuiz());
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showIsCorrectSnackBar(bool isCorrect) {
    final snackbar = SnackBar(
      backgroundColor: Colors.yellow,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height / 2 - 50,
      ),
      content: Text(
        isCorrect ? 'Correct!' : 'Not Correct.',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  quiz.getQuestionStmt(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              color: Colors.green,
              child: TextButton(
                onPressed: () => checkAnswer(true),
                child: const Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              color: Colors.red,
              child: TextButton(
                onPressed: () => checkAnswer(false),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
