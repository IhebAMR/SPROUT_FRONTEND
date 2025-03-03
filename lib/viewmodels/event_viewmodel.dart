import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';

class EventViewModel with ChangeNotifier {
  final EventService _eventService = EventService();
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    _events = await _eventService.getEvents();
    notifyListeners();
  }

  Future<void> createEvent(Event event) async {
    await _eventService.createEvent(event);
    await fetchEvents();
  }

  Future<void> updateEvent(Event event) async {
    await _eventService.updateEvent(event);
    await fetchEvents();
  }

 Future<void> deleteEvent(String id) async {
    try {
      await _eventService.deleteEvent(id);
      await fetchEvents(); // Rafraîchir la liste des événements après suppression
    } catch (e) {
      print('Error deleting event: $e');
    }
  }
}