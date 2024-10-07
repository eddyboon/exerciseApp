import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dumbbell), label: 'Workout'),
      ],
    );
  }
}
