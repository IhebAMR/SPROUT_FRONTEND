// lib/viewmodels/certification_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/certification.dart';

class CertificationViewModel with ChangeNotifier {
  List<Certification> _certifications = [];
  bool _isLoading = false;

  List<Certification> get certifications => _certifications;
  bool get isLoading => _isLoading;

  Future<void> generateCertification(String courseId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/certifications?courseId=$courseId&userId=$userId'),
      );
      if (response.statusCode == 201) {
        _certifications.add(Certification.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      print('Error generating certification: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserCertifications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/certifications/user/$userId'));
      if (response.statusCode == 200) {
        _certifications = (json.decode(response.body) as List)
            .map((data) => Certification.fromJson(data))
            .toList();
      }
    } catch (e) {
      print('Error fetching certifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}