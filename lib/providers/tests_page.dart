import "package:flutter/material.dart";

class TestsDetails with ChangeNotifier {
  final dynamic placeholder;

  TestsDetails({
    required this.placeholder,
  });

  void placeholderFunction() {
    notifyListeners();
  }
}

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  static const routeName = "/tests";

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder");
  }
}