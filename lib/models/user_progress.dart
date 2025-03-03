// lib/models/user_progress.dart
class UserProgress {
  final String id;
  final String userId;
  final String courseId;
  final double completionPercentage;
  final DateTime lastAccessed;

  UserProgress({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.completionPercentage,
    required this.lastAccessed,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      completionPercentage: json['completionPercentage'].toDouble(),
      lastAccessed: DateTime.parse(json['lastAccessed']),
    );
  }
}