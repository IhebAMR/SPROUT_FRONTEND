import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/api_service.dart';

class QuizViewModel extends ChangeNotifier {
  List<Quiz> quizzes = [];
  bool isLoading = true;
  final ApiService apiService = ApiService(baseUrl: 'https://your-api-base-url.com');

  Future<void> fetchQuizzes(String courseId) async {
    try {
      quizzes = await apiService.fetchQuizzes(courseId);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}