class Quiz {
  final String id;
  final String question;
  final List<String> options;
  final String answer;

  Quiz({required this.id, required this.question, required this.options, required this.answer});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}