// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/certification_viewmodel.dart';
import 'viewmodels/course_viewmodel.dart';
import 'viewmodels/quiz_viewmodel.dart';
import 'viewmodels/user_progress_viewmodel.dart';
import 'views/course_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CertificationViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewModel()),
        ChangeNotifierProvider(create: (_) => QuizViewModel()),
        ChangeNotifierProvider(create: (_) => UserProgressViewModel()),
      ],
      child: MaterialApp(
        title: 'Sprout Front',
        home: CourseView(),
      ),
    );
  }
}