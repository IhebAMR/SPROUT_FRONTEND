class BadgeModel {
  final String id;
  final String title;
  final String description;

  BadgeModel({required this.id, required this.title, required this.description});

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}