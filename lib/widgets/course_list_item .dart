import 'package:flutter/material.dart';
import '../models/course_model.dart';

class CourseListItem extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseListItem({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.title),
      subtitle: Text(course.description),
      onTap: onTap,
    );
  }
}