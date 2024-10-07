import 'package:flutter/material.dart';
import 'package:gymbro/navBar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Welcome to GymBro!'),
        ),
        appBar: AppBar(
          title: const Center(
            child: Text('GymBro!'),
          ),
        ),
        bottomNavigationBar: const Navbar(),
      ),
    );
  }
}
