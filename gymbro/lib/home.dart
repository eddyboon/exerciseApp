import 'package:flutter/material.dart';
import 'package:gymbro/components/home_page_exercises.dart';
import 'package:gymbro/components/home_page_reps.dart';
import 'package:gymbro/components/home_page_sets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 0, 0),
                child: Text(
                  "Today's Plan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Card(
              elevation: 3.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Workouts Column
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Workouts",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      HomePageWorkouts(workoutName: "Bench Press"),
                      HomePageWorkouts(workoutName: "Squats"),
                      HomePageWorkouts(workoutName: "Deadlifts"),
                    ],
                  ),
                  // Reps Column
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Reps",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      HomePageReps(reps: 3),
                      HomePageReps(reps: 5),
                      HomePageReps(reps: 3),
                    ],
                  ),
                  // Sets Column
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Sets",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      HomePageSets(sets: 5),
                      HomePageSets(sets: 3),
                      HomePageSets(sets: 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
