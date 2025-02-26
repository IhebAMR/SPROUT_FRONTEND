import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/event_viewmodel.dart';
import 'viewmodels/event_participant_viewmodel.dart';
import 'views/dashboard_screen.dart';
import 'models/user.dart';

void main() {
  // Simuler un utilisateur connecté
  final User currentUser = User(
    id: '1',
    name: 'John Doe',
    role: 'developer', // Changer ce rôle pour tester (admin, project_manager, developer)
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => EventParticipantViewModel()),
        Provider<User>.value(value: currentUser), // Fournir l'utilisateur actuel
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}