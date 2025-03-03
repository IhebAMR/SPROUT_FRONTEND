// lib/viewmodels/quiz_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/quiz.dart';

class QuizViewModel with ChangeNotifier {
  List<Quiz> _quizzes = [];
  bool _isLoading = false;

  List<Quiz> get quizzes => _quizzes;
  bool get isLoading => _isLoading;

  Future<void> createQuiz(Quiz quiz) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/quizzes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'courseId': quiz.courseId,
          'title': quiz.title,
          'description': quiz.description,
          'questions': quiz.questions.map((q) => {
                'question': q.question,
                'options': q.options,
                'answer': q.answer,
              }).toList(),
          'passingScore': quiz.passingScore,
        }),
      );
      if (response.statusCode == 201) {
        _quizzes.add(Quiz.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      print('Error creating quiz: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchQuizzesByCourseId(String courseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/quizzes/course/$courseId'));
      if (response.statusCode == 200) {
        _quizzes = (json.decode(response.body) as List)
            .map((data) => Quiz.fromJson(data))
            .toList();
      }
    } catch (e) {
      print('Error fetching quizzes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}