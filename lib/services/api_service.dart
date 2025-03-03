import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';
import '../models/application.dart';

class ApiService {
  // Assurez-vous que cette URL correspond à votre backend Spring Boot
  final String baseUrl = 'http://localhost:8082/api';

  Future<List<Project>> getProjects() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      // Afficher la réponse JSON pour le débogage
      print('API Response: ${response.body}');

      // Décoder la réponse JSON
      List<dynamic> data = jsonDecode(response.body);

      // Afficher les données désérialisées pour le débogage
      print('Deserialized Data: $data');

      // Convertir chaque objet JSON en un objet Project
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects: ${response.statusCode}');
    }
  } catch (e) {
    // Afficher l'erreur dans la console
    print('Error fetching projects: $e');
    throw Exception('Failed to load projects');
  }
}

  // Récupère un projet par son ID
  Future<Project> getProjectById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/projects/$id'));

      if (response.statusCode == 200) {
        return Project.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load project: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load project: $e');
    }
  }

Future<void> createProject(Project project) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'), // URL de l'API pour créer un projet
      headers: {'Content-Type': 'application/json'}, // En-tête JSON
      body: jsonEncode(project.toJson()), // Convertir le projet en JSON
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Succès : le projet a été créé
      print('Projet créé avec succès');
    } else {
      // Échec : lever une exception avec le code de statut et le corps de la réponse
      throw Exception('Failed to create project: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    // Gestion des erreurs (par exemple, problème de connexion)
    throw Exception('Failed to create project: $e');
  }
}

  // Supprime un projet par son ID
  Future<void> deleteProject(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/projects/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete project: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }

  // Récupère les candidatures associées à un projet
  Future<List<Application>> getApplicationsByProject(String projectId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/applications/project/$projectId'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((application) => Application.fromJson(application)).toList();
      } else {
        throw Exception('Failed to load applications: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load applications: $e');
    }
  }

  // Ajoute une candidature à un projet
  Future<Application> addApplicationToProject(String projectId, Application application) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/applications/$projectId/applications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(application.toJson()),
      );

      if (response.statusCode == 201) {
        return Application.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add application: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add application: $e');
    }
  }
}