import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/certificate_model.dart';

class CertificateViewModel extends ChangeNotifier {
  Certificate? certificate;
  bool isLoading = true;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080');

  Future<void> fetchCertificate(String courseId) async {
    try {
      certificate = await apiService.fetchCertificate(courseId);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}