class EventParticipant {
  final String id;
  final String eventId;
  final String userId;
  final String status;
  final DateTime registrationDate;
  final String feedback;
  final int rating;
  final bool checkInStatus;

  EventParticipant({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.status,
    required this.registrationDate,
    required this.feedback,
    required this.rating,
    required this.checkInStatus,
  });

  // Méthode fromJson pour convertir un JSON en EventParticipant
  factory EventParticipant.fromJson(Map<String, dynamic> json) {
    return EventParticipant(
      id: json['id'],
      eventId: json['eventId'],
      userId: json['userId'],
      status: json['status'],
      registrationDate: DateTime.parse(json['registrationDate']),
      feedback: json['feedback'],
      rating: json['rating'],
      checkInStatus: json['checkInStatus'],
    );
  }

  // Méthode toJson pour convertir un EventParticipant en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'status': status,
      'registrationDate': registrationDate.toIso8601String(),
      'feedback': feedback,
      'rating': rating,
      'checkInStatus': checkInStatus,
    };
  }

  // Méthode copyWith pour mettre à jour les propriétés
  EventParticipant copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? status,
    DateTime? registrationDate,
    String? feedback,
    int? rating,
    bool? checkInStatus,
  }) {
    return EventParticipant(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      registrationDate: registrationDate ?? this.registrationDate,
      feedback: feedback ?? this.feedback,
      rating: rating ?? this.rating,
      checkInStatus: checkInStatus ?? this.checkInStatus,
    );
  }
}