import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gymbro/home.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GymBro!'),
        ),
      ),
      body: SafeArea(
        child: <Widget>[
          const HomePage(),
          const Center(
            child: Text('Workouts'),
          ),
        ][currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.house),
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.dumbbell),
            icon: FaIcon(FontAwesomeIcons.dumbbell),
            label: "Workouts",
          ),
        ],
      ),
    );
  }
}
