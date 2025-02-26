import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/event_participant_viewmodel.dart';
import '../models/user.dart';

class ParticipantListScreen extends StatelessWidget {
  final String eventId;

  ParticipantListScreen({required this.eventId});

  @override
  Widget build(BuildContext context) {
    final participantViewModel = Provider.of<EventParticipantViewModel>(context);
    final currentUser = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
      ),
      body: FutureBuilder(
        future: participantViewModel.fetchParticipantsByEvent(eventId),
        builder: (context, snapshot) {
            return ListView.builder(
              itemCount: participantViewModel.participants.length,
              itemBuilder: (context, index) {
                final participant = participantViewModel.participants[index];
                return ListTile(
                  title: Text(participant.userId),
                  subtitle: Text(participant.status),
                  trailing: participant.status == 'Pending' &&
                          (currentUser.role == 'admin' || currentUser.role == 'project_manager')
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                participantViewModel.updateParticipant(participant.copyWith(status: 'Accepted'));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                participantViewModel.updateParticipant(participant.copyWith(status: 'Denied'));
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            );
        },
      ),
    );
  }
}