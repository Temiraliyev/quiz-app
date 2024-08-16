import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/quiz_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          child: const Text('QuizApp'),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const QuizzScreen(),
            ));
          },
        ),
      ),
    );
  }
}
