// lib/viewmodels/user_progress_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_progress.dart';

class UserProgressViewModel with ChangeNotifier {
  List<UserProgress> _progress = [];
  bool _isLoading = false;

  List<UserProgress> get progress => _progress;
  bool get isLoading => _isLoading;

  Future<void> updateProgress(String userId, String courseId, double completionPercentage) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('http://localhost:8080/api/progress?userId=$userId&courseId=$courseId&completionPercentage=$completionPercentage'),
      );
      if (response.statusCode == 200) {
        final updatedProgress = UserProgress.fromJson(json.decode(response.body));
        _progress.removeWhere((p) => p.userId == userId && p.courseId == courseId);
        _progress.add(updatedProgress);
      }
    } catch (e) {
      print('Error updating progress: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProgress(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/progress/user/$userId'));
      if (response.statusCode == 200) {
        _progress = (json.decode(response.body) as List)
            .map((data) => UserProgress.fromJson(data))
            .toList();
      }
    } catch (e) {
      print('Error fetching progress: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}