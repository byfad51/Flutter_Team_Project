import "package:flutter/material.dart";

class SummaryDetails with ChangeNotifier {
  final dynamic placeholder;

  SummaryDetails({
    required this.placeholder,
  });

  void placeholderFunction() {
    notifyListeners();
  }
}

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  static const routeName = "/summary";

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder");
  }
}