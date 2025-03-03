import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectDetails extends StatelessWidget {
  final Project project;

  ProjectDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Projet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Titre: ${project.title}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Description: ${project.description}'),
            SizedBox(height: 10),
            Text('Date de début: ${project.startDate}'),
            SizedBox(height: 10),
            Text('Date de fin: ${project.endDate}'),
            SizedBox(height: 10),
            Text('Statut: ${project.status}'),
          ],
        ),
      ),
    );
  }
}