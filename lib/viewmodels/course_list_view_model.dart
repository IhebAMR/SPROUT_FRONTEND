import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../services/api_service.dart';

class CourseListViewModel extends ChangeNotifier {
  List<Course> courses = [];
  bool isLoading = true;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080');

  CourseListViewModel() {
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      courses = await apiService.fetchCourses();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}