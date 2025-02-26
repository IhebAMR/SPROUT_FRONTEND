import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventService {
  final String _baseUrl = 'http://localhost:8080/api/events';

  Future<List<Event>> getEvents() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        print('API Response: ${response.body}'); // Log de la réponse
        List<dynamic> data = jsonDecode(response.body);
        print('Deserialized Data: $data'); // Log des données désérialisées
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e'); // Log de l'erreur
      throw Exception('Failed to load events');
    }
  }

  Future<void> createEvent(Event event) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(event.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create event');
    }
  }

  Future<void> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${event.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(event.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
}