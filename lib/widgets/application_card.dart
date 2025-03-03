import 'package:flutter/material.dart';
import '../models/application.dart';

class ApplicationCard extends StatelessWidget {
  final Application application;
  final VoidCallback onTap;

  const ApplicationCard({
    Key? key,
    required this.application,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(application.candidateEmail,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Statut : ${application.status}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
