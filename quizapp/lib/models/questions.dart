class Questions {
  String? questionText;
  String? difficulty;
  List<Answers>? answers;

  Questions({questionText, difficulty, answers});

  Questions.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    difficulty = json['difficulty'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['question_text'] = questionText;
    data['difficulty'] = difficulty;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? answerId;
  String? answerText;
  bool? isCorrect;

  Answers({answerId, answerText, isCorrect});

  Answers.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answerText = json['answer_text'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['answer_id'] = answerId;
    data['answer_text'] = answerText;
    data['is_correct'] = isCorrect;
    return data;
  }
}
