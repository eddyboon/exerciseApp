import 'package:flutter/material.dart';

class HomePageReps extends StatelessWidget {
  const HomePageReps({super.key, required this.reps});
  final int reps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 7.0),
      child: Text(
        reps.toString(),
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
