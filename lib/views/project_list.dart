import 'package:flutter/material.dart';
import '../models/project.dart';
import '../services/api_service.dart';
import 'project_form.dart';
import 'project_details.dart';

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final ApiService _apiService = ApiService();
  List<Project> _projects = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final projects = await _apiService.getProjects();
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors du chargement des projets: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Projets'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _projects.isEmpty
                  ? Center(child: Text('Aucun projet trouvé.'))
                  : ListView.builder(
                      itemCount: _projects.length,
                      itemBuilder: (context, index) {
                        Project project = _projects[index];
                        return ListTile(
                          title: Text(project.title),
                          subtitle: Text(project.description),
                          onTap: () {
                            // Naviguer vers l'écran des détails du projet
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProjectDetails(project: project),
                              ),
                            );
                          },
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Naviguer vers l'écran de création de projet et recharger après l'ajout
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProjectForm()),
          );
          _loadProjects();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
