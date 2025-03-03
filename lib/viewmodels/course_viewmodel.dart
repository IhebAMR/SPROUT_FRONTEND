// lib/viewmodels/course_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/course.dart';

class CourseViewModel with ChangeNotifier {
  List<Course> _courses = [];
  Course? _selectedCourse;
  bool _isLoading = false;
  String? _error;

  List<Course> get courses => _courses;
  Course? get selectedCourse => _selectedCourse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> createCourse(Course course) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/courses'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': course.title,
          'description': course.description,
          'duration': course.duration,
        }),
      );
      if (response.statusCode == 201) {
        _courses.add(Course.fromJson(json.decode(response.body)));
      } else {
        _error = 'Failed to create course: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error creating course: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
// lib/viewmodels/course_viewmodel.dart
Future<void> fetchAllCourses() async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    final response = await http.get(Uri.parse('http://localhost:8080/api/courses'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      _courses = (json.decode(response.body) as List)
          .map((data) => Course.fromJson(data))
          .toList();
    } else {
      _error = 'Failed to load courses: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    _error = 'Error fetching courses: $e';
    print('Exception details: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> fetchCourseById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/courses/$id'));
      if (response.statusCode == 200) {
        _selectedCourse = Course.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        _selectedCourse = null;
        _error = 'Course not found';
      } else {
        _error = 'Failed to load course: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error fetching course: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}