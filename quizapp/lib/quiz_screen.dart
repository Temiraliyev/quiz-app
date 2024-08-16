import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/api/api.dart';
import 'package:quizapp/api/response.dart';
import 'package:quizapp/models/questions.dart';
import 'package:quizapp/result_screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  List<Questions> data = [];
  bool isLoading = true;

  // ignore: non_constant_identifier_names
  int score = 0;
  int quantity = 0;
  bool btnPressed = false;
  bool finished = false;
  PageController? _controller;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    getData();
  }

  void getData() async {
    ApiResponse<List<Questions>> response = await Api().getQuestions();
    if (response.isSuccess) {
      setState(() {
        data = response.data!;
        data.shuffle();
        for (var question in data) {
          question.answers!.shuffle();
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: const Text("Quiz App"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    if (page == data.length - 1) {
                      setState(() {
                        finished = true;
                        quantity = data.length;
                      });
                    } else {
                      setState(() {
                        finished = false;
                      });
                    }
                    setState(() {
                      answered = false;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                              " ${"Вопросы"} ${index + 1}/${data.length}",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 28,
                                  )),
                        ),
                        Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: Text(
                            "${data[index].questionText}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 22,
                                ),
                          ),
                        ),
                        for (int i = 0; i < data[index].answers!.length; i++)
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: const EdgeInsets.only(
                                bottom: 20.0, left: 12.0, right: 12.0),
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: btnPressed
                                  ? data[index].answers![i].isCorrect!
                                      ? Colors.green
                                      : Colors.red
                                  : Theme.of(context).primaryColor,
                              onPressed: !answered
                                  ? () {
                                      if (data[index].answers![i].isCorrect!) {
                                        score++;
                                      }
                                      setState(() {
                                        btnPressed = true;
                                        answered = true;
                                      });
                                    }
                                  : null,
                              child: Text(
                                data[index].answers![i].answerText!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            answered
                                ? CupertinoButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      if (_controller!.page?.toInt() ==
                                          data.length - 1) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ResultScreen(
                                                  score, quantity);
                                            },
                                          ),
                                        );
                                      } else {
                                        _controller!.nextPage(
                                            duration: const Duration(
                                                milliseconds: 250),
                                            curve: Curves.easeInExpo);

                                        setState(() {
                                          btnPressed = false;
                                        });
                                      }
                                    },
                                    child: finished
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Завершить",
                                            ),
                                          )
                                        : const Text("Далее"),
                                  )
                                : CupertinoButton(
                                    color: Theme.of(context).disabledColor,
                                    child: finished
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Завершить",
                                            ),
                                          )
                                        : const Text("Далее"),
                                    onPressed: () {},
                                  ),
                          ],
                        )
                      ],
                    );
                  },
                  itemCount: data.length,
                ),
              ),
      ),
    );
  }
}
