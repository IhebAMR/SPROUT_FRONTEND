class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final int participantsCount;
  final List<String> reviews;
  final String eventType;
  final String organizerId;
  final String status;
  final String bannerImage;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.participantsCount,
    required this.reviews,
    required this.eventType,
    required this.organizerId,
    required this.status,
    required this.bannerImage,
  });

  // Méthode fromJson pour convertir un JSON en Event
  factory Event.fromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.parse(json['date']),
    location: json['location'],
    participantsCount: json['participantsCount'],
    reviews: List<String>.from(json['reviews'] ?? []), // Gérer le cas où reviews est null
    eventType: json['eventType'],
    organizerId: json['organizerId'],
    status: json['status'],
    bannerImage: json['bannerImage'],
  );
}
  // Méthode toJson pour convertir un Event en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'participantsCount': participantsCount,
      'reviews': reviews,
      'eventType': eventType,
      'organizerId': organizerId,
      'status': status,
      'bannerImage': bannerImage,
    };
  }
}