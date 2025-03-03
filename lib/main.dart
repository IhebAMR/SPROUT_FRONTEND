import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/project_viewmodel.dart';
import 'views/project_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Projets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProjectList(),
    );
  }
}