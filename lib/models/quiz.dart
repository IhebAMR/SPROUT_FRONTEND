// lib/models/quiz.dart
import 'package:sprout/models/question.dart';

class Quiz {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final List<Question> questions;
  final int passingScore;

  Quiz({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.questions,
    required this.passingScore,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      passingScore: json['passingScore'],
    );
  }
}