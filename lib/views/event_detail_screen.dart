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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          if (currentUser.role == 'admin' || currentUser.role == 'project_manager')
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/edit-event', arguments: event);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.primaryColorLight,
                // If we had actual banner images:
                // image: DecorationImage(
                //   image: NetworkImage(event.bannerImage),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            event.eventType.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Event details content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About this event',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColorDark,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            event.description,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Details section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColorDark,
                            ),
                          ),
                          SizedBox(height: 16),
                          
                          // Date and time
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: theme.primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date & Time',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: theme.primaryColorDark,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${event.date.toLocal().toString().split(' ')[0]} at ${event.date.toLocal().toString().split(' ')[1].substring(0, 5)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 16),
                          
                          // Location
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: theme.primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: theme.primaryColorDark,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      event.location,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 16),
                          
                          // Participants
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.people,
                                  color: theme.primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Participants',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: theme.primaryColorDark,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${event.participantsCount} registered',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ParticipantListScreen(eventId: event.id),
                                    ),
                                  );
                                },
                                child: Text('View All'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Action button for developers
                  if (currentUser.role == 'developer')
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add_circle),
                        label: Text('Join Event'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                        ),
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
                            SnackBar(
                              content: Text('You have requested to join the event'),
                              backgroundColor: theme.primaryColorDark,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}