import 'package:flutter/material.dart';

class ErrorRouterPage extends StatelessWidget {
  const ErrorRouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Erreur lors de la résolution d\'une page'),
      ),
    );
  }
}
