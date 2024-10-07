import 'package:flutter/material.dart';

class HomePageSets extends StatelessWidget {
  const HomePageSets({super.key, required this.sets});
  final int sets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 7.0),
      child: Text(
        sets.toString(),
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
