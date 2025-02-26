import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/course_list_view_model.dart';
import '../widgets/course_list_item .dart';
import 'course_detail_view.dart';

class CourseListView extends StatelessWidget {
  const CourseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: Consumer<CourseListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.courses.length,
            itemBuilder: (context, index) {
              return CourseListItem(
                course: viewModel.courses[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailView(course: viewModel.courses[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}