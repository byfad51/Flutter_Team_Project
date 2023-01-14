import "package:flutter/material.dart";

class ScheduleDetails with ChangeNotifier {
  final dynamic placeholder;

  ScheduleDetails({
    required this.placeholder,
  });

  void placeholderFunction() {
    notifyListeners();
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  static const routeName = "/schedule";

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder");
  }
}