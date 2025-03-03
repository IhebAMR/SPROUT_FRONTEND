// lib/models/course.dart
class Course {
  final String id;
  final String title;
  final String description;
  final int duration;
    final String? videoUrl; // Nullable in case not all courses have videos


  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
        this.videoUrl,

  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
            videoUrl: json['videoUrl'],

    );
  }
}