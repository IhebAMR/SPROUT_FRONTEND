// lib/models/certification.dart
class Certification {
  final String id;
  final String courseId;
  final String userId;
  final DateTime dateAwarded;

  Certification({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.dateAwarded,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      id: json['id'],
      courseId: json['courseId'],
      userId: json['userId'],
      dateAwarded: DateTime.parse(json['dateAwarded']),
    );
  }
}