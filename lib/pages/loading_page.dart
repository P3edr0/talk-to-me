import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.orange[700],
            ),
            const SizedBox(height: 10),
            const Text("Carregando ...",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        )));
  }
}
