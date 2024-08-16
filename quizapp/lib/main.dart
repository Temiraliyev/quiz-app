import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final List<Map<String, dynamic>> quizData = [
    {
      "question_text": "Кто был первым президентом США?",
      "difficulty": "easy",
      "answers": [
        {
          "answer_id": "19",
          "answer_text": "Джордж Вашингтон",
          "is_correct": true
        },
        {
          "answer_id": "20",
          "answer_text": "Абрахам Линкольн",
          "is_correct": false
        },
        {
          "answer_id": "21",
          "answer_text": "Томас Джефферсон",
          "is_correct": false
        },
      ],
    },
    {
      "question_text": "Какой год считается началом Второй мировой войны?",
      "difficulty": "medium",
      "answers": [
        {"answer_id": "22", "answer_text": "1939", "is_correct": true},
        {"answer_id": "23", "answer_text": "1941", "is_correct": false},
        {"answer_id": "24", "answer_text": "1938", "is_correct": false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return QuizQuestion(
            questionText: quizData[index]['question_text'],
            answers:
                List<Map<String, dynamic>>.from(quizData[index]['answers']),
          );
        },
      ),
    );
  }
}

class QuizQuestion extends StatelessWidget {
  final String questionText;
  final List<Map<String, dynamic>> answers;

  QuizQuestion({required this.questionText, required this.answers});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              questionText,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ...answers.map((answer) {
              return AnswerWidget(answer: answer);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class AnswerWidget extends StatelessWidget {
  final Map<String, dynamic> answer;

  AnswerWidget({required this.answer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool isCorrect = answer['is_correct'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isCorrect ? 'Correct!' : 'Wrong!'),
            backgroundColor: isCorrect ? Colors.green : Colors.red,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blueAccent,
        ),
        child: Text(
          answer['answer_text'],
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
