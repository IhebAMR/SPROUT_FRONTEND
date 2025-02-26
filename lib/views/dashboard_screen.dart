import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/event_viewmodel.dart';
import 'event_detail_screen.dart';
import 'event_form_screen.dart';
import '../models/user.dart';
 // Assurez-vous d'importer le modèle Event

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    final currentUser = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Events Dashboard'),
      ),
      body: FutureBuilder(
        future: eventViewModel.fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (eventViewModel.events.isEmpty) {
            return Center(child: Text('No events available.'));
          } else {
            return ListView.builder(
              itemCount: eventViewModel.events.length,
              itemBuilder: (context, index) {
                final event = eventViewModel.events[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre de l'événement
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Description de l'événement
                        Text(
                          event.description,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        // Date et lieu de l'événement
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Date: ${event.date.toLocal().toString().split(' ')[0]}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Location: ${event.location}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Boutons d'action
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Bouton pour voir les détails
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(event: event),
                                  ),
                                );
                              },
                              child: Text('View Details'),
                            ),
                            // Bouton de modification (visible uniquement pour admin et project manager)
                            if (currentUser.role == 'admin' || currentUser.role == 'project_manager')
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventFormScreen(event: event),
                                    ),
                                  );
                                },
                                child: Text('Edit'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      // Bouton pour ajouter un nouvel événement (visible uniquement pour admin et project manager)
      floatingActionButton: currentUser.role == 'admin' || currentUser.role == 'project_manager'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventFormScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}