import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/crosslistelement.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/quiz_screen.dart';
import 'package:quizapp/widget/itemcard.dart';
import 'package:quizapp/widget/resultscreen.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  ResultScreen(this.score, this.quantity, {super.key});

  int score;
  int quantity;

  @override
  // ignore: library_private_types_in_public_api
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(
                50,
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: const Icon(
              CupertinoIcons.check_mark,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "test_completed",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
          ),
          Text("Siz bu testdan ${widget.score} ball to'pladingiz",
              style: Theme.of(context).textTheme.bodyMedium!),
          SettingItemCard(
            column: Column(
              children: [
                const ResultScreenWidget(
                  icon: CupertinoIcons.time,
                  title: "time",
                  subtitleText: "",
                  divider: true,
                  text: '05:57',
                ),
                ResultScreenWidget(
                  icon: Icons.score_outlined,
                  title: "ball",
                  subtitleText: "",
                  divider: true,
                  text: "${widget.score}-${"ball".toLowerCase()}",
                ),
                ResultScreenWidget(
                  icon: Icons.percent,
                  title: "accuracy",
                  subtitleText: "",
                  text: "${((widget.score / widget.quantity) * 100).toInt()}%",
                ),
              ],
            ),
            title: '',
          ),
          SettingItemCard(
              column: Column(
                children: [
                  CrossListElement(
                    divider: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios),
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                            "see_result",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              title: ''),
          const SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "retry",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const QuizzScreen();
                  }));
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "next",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
