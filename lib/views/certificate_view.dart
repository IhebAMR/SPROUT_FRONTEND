import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels//certificate_view_model.dart';

class CertificateView extends StatelessWidget {
  final String courseId;

  const CertificateView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    context.read<CertificateViewModel>().fetchCertificate(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate for $courseId'),
      ),
      body: Consumer<CertificateViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final certificate = viewModel.certificate;
          if (certificate == null) {
            return const Center(child: Text('No certificate found'));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(certificate.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Course: $courseId'),
                Text('Date: ${certificate.date}'),
              ],
            ),
          );
        },
      ),
    );
  }
}