import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/course_detail_view_model.dart';
import 'quiz_view.dart';
import 'certificate_view.dart';
import 'badges_view .dart';
import '../models/course_model.dart';

class CourseDetailView extends StatelessWidget {
  final Course course;

  const CourseDetailView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    context.read<CourseDetailViewModel>().setCourse(course);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              course.description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizView(courseId: course.id),
                ),
              );
            },
            child: const Text('Start Quiz'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CertificateView(courseId: course.id),
                ),
              );
            },
            child: const Text('View Certificate'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BadgesView(courseId: course.id),
                ),
              );
            },
            child: const Text('View Badges'),
          ),
        ],
      ),
    );
  }
}