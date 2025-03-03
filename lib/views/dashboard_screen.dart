import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/event_viewmodel.dart';
import 'event_detail_screen.dart';
import 'event_form_screen.dart';
import '../models/user.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    final currentUser = Provider.of<User>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Events Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => eventViewModel.fetchEvents(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
        ),
        child: FutureBuilder(
          future: eventViewModel.fetchEvents(),
          builder: (context, snapshot) {
             if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red),
                    SizedBox(height: 16),
                    Text('Error: ${snapshot.error}',
                        style: theme.textTheme.titleLarge),
                    TextButton(
                      onPressed: () => eventViewModel.fetchEvents(),
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else if (eventViewModel.events.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: theme.primaryColorLight),
                    SizedBox(height: 16),
                    Text('No events available.',
                        style: theme.textTheme.titleLarge),
                    if (currentUser.role == 'admin' || currentUser.role == 'project_manager')
                      ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Create New Event'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventFormScreen(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            } else {
              return // Dans dashboard_screen.dart, remplacez la partie ListView.builder par ce code:
// Replace the ListView.builder in dashboard_screen.dart with this GridView implementation
GridView.builder(
  padding: EdgeInsets.all(8.0), // Moins d'espace autour du grid
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Deux cartes par ligne
    crossAxisSpacing: 6.0, // Moins d'espace entre cartes
    mainAxisSpacing: 6.0,
    childAspectRatio: 1.2, // Cartes plus compactes
  ),
  itemCount: eventViewModel.events.length,
  itemBuilder: (context, index) {
    final event = eventViewModel.events[index];
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bannière avec type et date
          Container(
            height: 60, // Hauteur réduite
            decoration: BoxDecoration(
              color: theme.primaryColorLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      event.eventType.toUpperCase(),
                      style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 10, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        '${event.date.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Contenu principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Text(
                  event.title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.primaryColorDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                // Emplacement
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10, color: theme.primaryColorDark),
                    SizedBox(width: 3),
                    Expanded(
                      child: Text(event.location, style: TextStyle(fontSize: 10, color: Colors.grey[600]), overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                // Participants
                Row(
                  children: [
                    Icon(Icons.people, size: 10, color: theme.primaryColorDark),
                    SizedBox(width: 3),
                    Text('${event.participantsCount} participants', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          // Icônes d'actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icône détails
                IconButton(
                  icon: Icon(Icons.info_outline, size: 16, color: theme.primaryColorDark),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventDetailScreen(event: event)),
                    );
                  },
                ),
                if (currentUser.role == 'admin' || currentUser.role == 'project_manager') ...[
                  // Icône modifier
                  IconButton(
                    icon: Icon(Icons.edit, size: 16, color: theme.primaryColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventFormScreen(event: event)),
                      );
                    },
                  ),
                  // Icône supprimer
                  IconButton(
                    icon: Icon(Icons.delete, size: 16, color: Colors.red),
                    onPressed: () async {
                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Supprimer l\'événement'),
                          content: Text('Êtes-vous sûr de vouloir supprimer cet événement ?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Annuler')),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirmDelete == true) {
                        await eventViewModel.deleteEvent(event.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Événement supprimé avec succès'), backgroundColor: theme.primaryColorDark),
                        );
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  },
);


            }
          },
        ),
      ),
      // Floating action button (admin & project manager only)
      floatingActionButton: currentUser.role == 'admin' || currentUser.role == 'project_manager'
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventFormScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text('New Event'),
            )
          : null,
    );
  }
}