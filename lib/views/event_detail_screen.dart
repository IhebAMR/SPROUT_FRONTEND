import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/models/event_participant.dart';
import '../viewmodels/event_participant_viewmodel.dart';
import '../models/event.dart';
import '../models/user.dart';
import 'participant_list_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final participantViewModel = Provider.of<EventParticipantViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Date: ${event.date.toString()}'),
            Text('Location: ${event.location}'),
            Text('Participants: ${event.participantsCount}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParticipantListScreen(eventId: event.id),
                  ),
                );
              },
              child: Text('View Participants'),
            ),
            if (currentUser.role == 'developer')
              ElevatedButton(
                onPressed: () {
                  participantViewModel.registerParticipant(EventParticipant(
                    id: 'temp-id',
                    eventId: event.id,
                    userId: currentUser.id,
                    status: 'Pending',
                    registrationDate: DateTime.now(),
                    feedback: '',
                    rating: 0,
                    checkInStatus: false,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You have requested to join the event')),
                  );
                },
                child: Text('Join Event'),
              ),
          ],
        ),
      ),
    );
  }
}