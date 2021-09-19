// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Quiz(),
  ));
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // List of Questions with answers
  // questionBank[0][0] : Access Question 1
  // questionBank[0][1] : Access Answer 1
  // questionBank[2][0] : Access Question 3
  // questionBank[2][1] : Access Answer 3

  List questionBank = [
    ['many pepole are dog lover', true],
    ['all pepole love to read book .', false],
    ['Approximately humans have 260 bones .', true],
    ['A slug\'s blood is green.', true],
    ['Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true],
    ['It is illegal to pee in the Ocean in Portugal.', true],
    ['No piece of square dry paper can be folded in half of 3 times.', false],
    [
      'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
      true
    ],
    [
      'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
      false
    ],
    [
      'The total surface area of two human lungs is approximately 70 square metres.',
      true
    ],
    ['Google was originally called \"Backrub\".', true],
    [
      'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      true
    ],
    [
      'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
      true
    ],
  ];

  // Question counter
  int questionNo = 0;
  // Right & wrong counter
  int right = 0, wrong = 0;
  // Score Keeper List
  List<Icon> scoreKeeper = [];

  // Logic
  // 1. NextQuestion
  void nextQuestion() {
    if (questionNo < questionBank.length) {
      questionNo++;
    }
  }

  // 2. Access Question & Access correct answer
  String getQuestion() {
    return questionBank[questionNo][0];
  }

  bool correctAnswer() {
    return questionBank[questionNo][1];
  }

  // 3. To check if quiz ended or not
  bool isFinished() {
    if (questionNo >= questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  // 4. To check user picked answer
  void checkAns(bool userPicked) {
    setState(() {
      if (isFinished() == true) {
        // reset quiz
        questionNo = 0;
        scoreKeeper = [];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SecondPage(right, wrong);
          }),
        );
      } else {
        // Compare answers
        if (userPicked == correctAnswer()) {
          right++;
          print("right");
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          wrong++;
          print("wrong");
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }

        // nextquestion
        nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Question Text
          Expanded(
            flex: 6,
            // Click Ctrl + . to wrap with center
            child: Center(
              child: Text(
                getQuestion(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          // 2. True Button
          Expanded(
            // Ctrl + . to wrap with padding
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextButton(
                onPressed: () {
                  checkAns(true);
                },
                child: Text(
                  "True",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
          ),
          // 3. False Button
          Expanded(
            // Ctrl + . to wrap with padding
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextButton(
                onPressed: () {
                  checkAns(false);
                },
                child: Text(
                  "False",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
          ),
          // 4. Answer Icon
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------
// secondPage.dart

class SecondPage extends StatelessWidget {
  int right;
  int wrong;
  SecondPage(this.right, this.wrong);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Right: $right"),
            Text("Wrong: $wrong"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Quiz();
                  }),
                );
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
