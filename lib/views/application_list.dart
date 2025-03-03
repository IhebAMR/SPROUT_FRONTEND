import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/application_viewmodel.dart';
import '../models/application.dart';
import 'application_form.dart';

class ApplicationList extends StatelessWidget {
  final String projectId;

  ApplicationList({required this.projectId});

  @override
  Widget build(BuildContext context) {
    final applicationViewModel = Provider.of<ApplicationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
      ),
      body: applicationViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: applicationViewModel.applications.length,
              itemBuilder: (context, index) {
                Application application = applicationViewModel.applications[index];
                return ListTile(
                  title: Text(application.candidateEmail),
                  subtitle: Text(application.status.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationForm(application: application),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApplicationForm(projectId: projectId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}