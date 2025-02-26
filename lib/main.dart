import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/course_list_view_model.dart';
import 'viewmodels/course_detail_view_model.dart';
import 'viewmodels/quiz_view_model.dart';
import 'viewmodels/certificate_view_model.dart';
import 'viewmodels/badges_view_model.dart';
import 'views/course_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseListViewModel()),
        ChangeNotifierProvider(create: (_) => CourseDetailViewModel()),
        ChangeNotifierProvider(create: (_) => QuizViewModel()),
        ChangeNotifierProvider(create: (_) => CertificateViewModel()),
        ChangeNotifierProvider(create: (_) => BadgesViewModel()),
      ],
      child: MaterialApp(
        title: 'Course Platform',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CourseListView(),
      ),
    );
  }
}