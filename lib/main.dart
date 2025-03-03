import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/views/dashboard_screen.dart';
import 'theme/app_theme.dart'; // Import the theme file
import 'viewmodels/event_viewmodel.dart';
import 'viewmodels/event_participant_viewmodel.dart';
import 'models/user.dart';
// Import other necessary files

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => EventParticipantViewModel()),
        Provider<User>(create: (_) => User(id: '1',name: 'mohamed', role: 'admin')), // For demo purposes
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management App',
      theme: AppTheme.lightTheme, // Apply the theme
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}