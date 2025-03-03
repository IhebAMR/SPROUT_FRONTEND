import 'package:sprout/models/application.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<String> backlog;
  final List<Application> applications;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.backlog,
    required this.applications,
    required this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '', // Utiliser une chaîne vide si 'id' est null
      title: json['title'] ?? 'Sans titre', // Utiliser une valeur par défaut si 'title' est null
      description: json['description'] ?? 'Pas de description', // Utiliser une valeur par défaut si 'description' est null
      startDate: DateTime.parse(json['startDate'] ?? '1970-01-01'), // Utiliser une date par défaut si 'startDate' est null
      endDate: DateTime.parse(json['endDate'] ?? '1970-01-01'), // Utiliser une date par défaut si 'endDate' est null
      status: json['status'] ?? 'Inconnu', // Utiliser une valeur par défaut si 'status' est null
      backlog: List<String>.from(json['backlog'] ?? []), // Utiliser une liste vide si 'backlog' est null
      applications: List<Application>.from((json['applications'] ?? []).map((x) => Application.fromJson(x))), // Utiliser une liste vide si 'applications' est null
      createdAt: DateTime.parse(json['createdAt'] ?? '1970-01-01T00:00:00.000'), // Utiliser une date par défaut si 'createdAt' est null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'backlog': backlog,
      'applications': applications.map((x) => x.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}