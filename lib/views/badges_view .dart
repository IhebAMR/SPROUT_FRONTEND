import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/badges_view_model.dart';
import '../models/badge_model.dart' as model;

class BadgesView extends StatelessWidget {
  final String courseId;

  const BadgesView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    context.read<BadgesViewModel>().fetchBadges(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Badges for $courseId'),
      ),
      body: Consumer<BadgesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.badges.length,
            itemBuilder: (context, index) {
              final model.BadgeModel badge = viewModel.badges[index];
              return ListTile(
                title: Text(badge.title),
                subtitle: Text(badge.description),
              );
            },
          );
        },
      ),
    );
  }
}