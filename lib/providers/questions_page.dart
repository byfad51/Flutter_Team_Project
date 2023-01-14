import "package:flutter/material.dart";

class QuestionDetails with ChangeNotifier {
  final dynamic placeholder;

  QuestionDetails({
    required this.placeholder,
  });

  void placeholderFunction() {
    notifyListeners();
  }
}

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  static const routeName = "/questions";

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder");
  }
}