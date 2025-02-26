import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_view_model.dart';

class QuizView extends StatelessWidget {
  final String courseId;

  const QuizView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    context.read<QuizViewModel>().fetchQuizzes(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz for $courseId'),
      ),
      body: Consumer<QuizViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.quizzes.length,
            itemBuilder: (context, index) {
              final quiz = viewModel.quizzes[index];
              return ListTile(
                title: Text(quiz.question),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: quiz.options.map<Widget>((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: quiz.answer,
                      onChanged: (value) {},
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}