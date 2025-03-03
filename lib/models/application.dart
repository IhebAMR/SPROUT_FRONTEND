import 'package:flutter/foundation.dart';
import 'package:sprout/models/%20application_status.dart';
import 'project.dart';

class Application {
  final String id;
  final Project project;
  final String userId;
  final String candidateEmail;
  final ApplicationStatus status;
  final DateTime createdAt;

  Application({
    required this.id,
    required this.project,
    required this.userId,
    required this.candidateEmail,
    required this.status,
    required this.createdAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      project: Project.fromJson(json['project']),
      userId: json['userId'],
      candidateEmail: json['candidateEmail'],
      status: ApplicationStatus.values.firstWhere((e) => describeEnum(e) == json['status']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project': project.toJson(),
      'userId': userId,
      'candidateEmail': candidateEmail,
      'status': describeEnum(status),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}