import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/models/%20application_status.dart';
import 'package:sprout/models/project.dart';
import '../viewmodels/application_viewmodel.dart';
import '../models/application.dart';


class ApplicationForm extends StatefulWidget {
  final Application? application;
  final String? projectId;

  ApplicationForm({this.application, this.projectId});

  @override
  _ApplicationFormState createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _userId;
  late String _candidateEmail;
  late ApplicationStatus _status;

  @override
  void initState() {
    super.initState();
    if (widget.application != null) {
      _userId = widget.application!.userId;
      _candidateEmail = widget.application!.candidateEmail;
      _status = widget.application!.status;
    } else {
      _userId = '';
      _candidateEmail = '';
      _status = ApplicationStatus.PENDING;
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicationViewModel = Provider.of<ApplicationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.application == null ? 'Create Application' : 'Edit Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _userId,
                decoration: InputDecoration(labelText: 'User ID'),
                onChanged: (value) {
                  setState(() {
                    _userId = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _candidateEmail,
                decoration: InputDecoration(labelText: 'Candidate Email'),
                onChanged: (value) {
                  setState(() {
                    _candidateEmail = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a candidate email';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<ApplicationStatus>(
                value: _status,
                onChanged: (ApplicationStatus? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: ApplicationStatus.values.map((ApplicationStatus status) {
                  return DropdownMenuItem<ApplicationStatus>(
                    value: status,
                    child: Text(status.toString()),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Application application = Application(
                      id: widget.application?.id ?? '',
                      project: widget.application?.project ?? Project(
                        id: widget.projectId!,
                        title: '',
                        description: '',
                        startDate: DateTime.now(),
                        endDate: DateTime.now(),
                        status: '',
                        backlog: [],
                        applications: [],
                        createdAt: DateTime.now(),
                      ),
                      userId: _userId,
                      candidateEmail: _candidateEmail,
                      status: _status,
                      createdAt: DateTime.now(),
                    );
                    if (widget.application == null) {
                      await applicationViewModel.addApplicationToProject(widget.projectId!, application);
                    } else {
                      // Implement update logic if needed
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}