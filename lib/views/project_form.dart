import 'package:flutter/material.dart';
import '../models/project.dart'; // Importez votre modèle Project

class ProjectForm extends StatefulWidget {
  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _status = 'En cours'; // Valeur par défaut
  final List<String> _backlog = []; // Liste des tâches du backlog

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Créer un nouvel objet Project avec les données du formulaire
      Project newProject = Project(
        id: '', // L'ID sera généré par le backend
        title: _titleController.text,
        description: _descriptionController.text,
        startDate: _startDate ?? DateTime.now(), // Utiliser la date actuelle si non définie
        endDate: _endDate ?? DateTime.now().add(Duration(days: 30)), // Date de fin par défaut
        status: _status,
        backlog: _backlog,
        applications: [], // Aucune candidature au départ
        createdAt: DateTime.now(),
      );

      // Faire quelque chose avec le nouveau projet (par exemple, l'envoyer au backend)
      print('Nouveau projet créé: ${newProject.toJson()}');

      // Fermer le formulaire
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addBacklogItem() {
    showDialog(
      context: context,
      builder: (context) {
        final _backlogItemController = TextEditingController();
        return AlertDialog(
          title: Text('Ajouter une tâche au backlog'),
          content: TextField(
            controller: _backlogItemController,
            decoration: InputDecoration(labelText: 'Tâche'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _backlog.add(_backlogItemController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un Projet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Date de début: ${_startDate?.toString() ?? "Non définie"}'),
              ElevatedButton(
                onPressed: () => _selectDate(context, true),
                child: Text('Choisir la date de début'),
              ),
              SizedBox(height: 16),
              Text('Date de fin: ${_endDate?.toString() ?? "Non définie"}'),
              ElevatedButton(
                onPressed: () => _selectDate(context, false),
                child: Text('Choisir la date de fin'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: <String>['En cours', 'Terminé', 'En attente']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Statut'),
              ),
              SizedBox(height: 16),
              Text('Backlog:'),
              ..._backlog.map((item) => ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _backlog.remove(item);
                        });
                      },
                    ),
                  )),
              ElevatedButton(
                onPressed: _addBacklogItem,
                child: Text('Ajouter une tâche au backlog'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Créer le projet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}