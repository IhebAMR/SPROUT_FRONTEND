import 'package:flutter/material.dart';
import '../models/project.dart';
import '../services/api_service.dart';

class ProjectViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService(); // Utilisation du service API
  List<Project> _projects = []; // Liste des projets
  bool _isLoading = false; // Indicateur de chargement
  String _errorMessage = ''; // Message d'erreur

  // Getters pour accéder aux données
  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Charge la liste des projets depuis le backend
  Future<void> fetchProjects() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _projects = await _apiService.getProjects(); // Appel au service API
      _errorMessage = ''; // Réinitialiser le message d'erreur en cas de succès
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des projets: $e'; // Gestion des erreurs
      print(_errorMessage); // Afficher l'erreur dans la console
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifier les écouteurs que l'état a changé
    }
  }

  // Crée un nouveau projet
  Future<void> createProject(Project project) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _apiService.createProject(project); // Appel au service API
      await fetchProjects(); // Recharger la liste des projets après création
    } catch (e) {
      _errorMessage = 'Erreur lors de la création du projet: $e'; // Gestion des erreurs
      print(_errorMessage); // Afficher l'erreur dans la console
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifier les écouteurs que l'état a changé
    }
  }

  // Supprime un projet par son ID
  Future<void> deleteProject(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _apiService.deleteProject(id); // Appel au service API
      await fetchProjects(); // Recharger la liste des projets après suppression
    } catch (e) {
      _errorMessage = 'Erreur lors de la suppression du projet: $e'; // Gestion des erreurs
      print(_errorMessage); // Afficher l'erreur dans la console
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifier les écouteurs que l'état a changé
    }
  }

  // Met à jour un projet existant
  Future<void> updateProject(Project project) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Implémentez la logique de mise à jour si nécessaire
      // Exemple : await _apiService.updateProject(project);
      await fetchProjects(); // Recharger la liste des projets après mise à jour
    } catch (e) {
      _errorMessage = 'Erreur lors de la mise à jour du projet: $e'; // Gestion des erreurs
      print(_errorMessage); // Afficher l'erreur dans la console
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifier les écouteurs que l'état a changé
    }
  }
}