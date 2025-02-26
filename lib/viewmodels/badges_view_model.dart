import 'package:flutter/material.dart';
import '../models/badge_model.dart';
import '../services/api_service.dart';

class BadgesViewModel extends ChangeNotifier {
  List<BadgeModel> badges = [];
  bool isLoading = true;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080');

  Future<void> fetchBadges(String courseId) async {
    try {
      badges = await apiService.fetchBadges(courseId);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}