import 'package:flutter/material.dart';
import '../models/course_model.dart';

class CourseDetailViewModel extends ChangeNotifier {
  Course? course;

  void setCourse(Course course) {
    this.course = course;
    notifyListeners();
  }
}