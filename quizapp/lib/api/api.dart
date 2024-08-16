import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quizapp/api/response.dart';
import 'package:quizapp/models/questions.dart';

class Api {
  // Question list
  Future<ApiResponse<List<Questions>>> getQuestions() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2/demo/get_question.php"));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Questions> list = [];
        for (var element in jsonList) {
          list.add(Questions.fromJson(element));
        }
        return ApiResponse.success(data: list);
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
        return ApiResponse.error(
            message:
                "Failed to load questions. Status code: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      return ApiResponse.error(message: "An error occurred: $e");
    }
  }
}
