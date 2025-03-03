import 'package:flutter/material.dart';
import '../models/event_participant.dart';
import '../services/event_participant_service.dart';

class EventParticipantViewModel with ChangeNotifier {
  final EventParticipantService _eventParticipantService = EventParticipantService();
  List<EventParticipant> _participants = [];

  List<EventParticipant> get participants => _participants;

  Future<void> fetchParticipantsByEvent(String eventId) async {
    _participants = await _eventParticipantService.getParticipantsByEvent(eventId);
    notifyListeners();
  }

  Future<void> registerParticipant(EventParticipant participant) async {
    await _eventParticipantService.registerParticipant(participant);
    await fetchParticipantsByEvent(participant.eventId);
  }

  Future<void> updateParticipant(EventParticipant participant) async {
    await _eventParticipantService.updateParticipant(participant);
    await fetchParticipantsByEvent(participant.eventId);
  }

  Future<void> deleteParticipant(String id) async {
    await _eventParticipantService.deleteParticipant(id);
    notifyListeners();
  }

  fetchParticipantsByUser(String id) {}
}