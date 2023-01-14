import "package:flutter/material.dart";

class AuthenticationDetails with ChangeNotifier {
  final dynamic placeholder;

  AuthenticationDetails({
    required this.placeholder,
  });

  void placeholderFunction() {
    notifyListeners();
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder");
  }
}