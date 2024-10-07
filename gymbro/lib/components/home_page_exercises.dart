import 'package:flutter/material.dart';

class HomePageWorkouts extends StatelessWidget {
  const HomePageWorkouts({super.key, required this.workoutName});
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 7.0),
      child: Text(
        workoutName,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
