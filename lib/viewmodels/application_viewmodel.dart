import 'package:flutter/material.dart';
import '../models/application.dart';
import '../services/api_service.dart';

class ApplicationViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService(); // Appel direct au service
  List<Application> _applications = [];
  bool _isLoading = false;

  List<Application> get applications => _applications;
  bool get isLoading => _isLoading;

  Future<void> fetchApplicationsByProject(String projectId) async {
    _isLoading = true;
    notifyListeners();
    _applications = await _apiService.getApplicationsByProject(projectId); // Appel direct au service
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addApplicationToProject(String projectId, Application application) async {
    await _apiService.addApplicationToProject(projectId, application); // Appel direct au service
    await fetchApplicationsByProject(projectId);
  }
}