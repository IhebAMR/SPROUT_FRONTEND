class Certificate {
  final String id;
  final String title;
  final String date;

  Certificate({required this.id, required this.title, required this.date});

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }
}