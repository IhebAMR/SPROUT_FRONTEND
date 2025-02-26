import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';
import '../models/quiz_model.dart';
import '../models/certificate_model.dart';
import '../models/badge_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((courseJson) => Course.fromJson(courseJson)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<Quiz>> fetchQuizzes(String courseId) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$courseId/quizzes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((quizJson) => Quiz.fromJson(quizJson)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  Future<Certificate> fetchCertificate(String courseId) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$courseId/certificate'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Certificate.fromJson(data);
    } else {
      throw Exception('Failed to load certificate');
    }
  }

  Future<List<BadgeModel>> fetchBadges(String courseId) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$courseId/badges'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((badgeJson) => BadgeModel.fromJson(badgeJson)).toList();
    } else {
      throw Exception('Failed to load badges');
    }
  }
}