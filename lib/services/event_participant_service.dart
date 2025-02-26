import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_participant.dart';

class EventParticipantService {
  final String _baseUrl = 'http://localhost:8080/api/event-participants';

  Future<List<EventParticipant>> getParticipantsByEvent(String eventId) async {
    final response = await http.get(Uri.parse('$_baseUrl/event/$eventId'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => EventParticipant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load participants');
    }
  }

  Future<void> registerParticipant(EventParticipant participant) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(participant.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to register participant');
    }
  }

  Future<void> updateParticipant(EventParticipant participant) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${participant.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(participant.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update participant');
    }
  }

  Future<void> deleteParticipant(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete participant');
    }
  }
}