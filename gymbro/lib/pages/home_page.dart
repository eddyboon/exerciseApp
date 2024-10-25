import 'package:flutter/material.dart';
import 'package:gymbro/backend/database/database_services.dart';
import 'package:gymbro/backend/models/exercise.dart';
import 'package:gymbro/components/home_page_exercises.dart';
import 'package:gymbro/components/home_page_reps.dart';
import 'package:gymbro/components/home_page_sets.dart';
import 'package:gymbro/pages/add_workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService databaseService = DatabaseService.instance;

  // function to get all exercises
  Future<List<Exercise>> getExercises() async {
    final db = await databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('exercises');
    return List.generate(maps.length, (index) {
      return Exercise(
        name: maps[index]['name'],
        sets: maps[index]['sets'],
        reps: maps[index]['reps'],
        type: maps[index]['type'],
      );
    });
  }

  // init state
  @override
  void initState() {
    super.initState();
    // Iterate through all exercises and print them
/*    getExercises().then((value) {
      value.forEach((element) {
        print(element.name);
        print(element.reps);
        print(element.sets);
        print(element.type);
      });
    });
*/
    databaseService.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Today's Plan Title
          const Row(
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
          // Today's Plan Card
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
                      StreamBuilder(
                          stream: databaseService.exerciseNames,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: snapshot.data!
                                    .map((workoutName) => HomePageWorkouts(
                                        workoutName: workoutName))
                                    .toList(),
                              );
                            } else {
                              return HomePageWorkouts(workoutName: "-");
                            }
                          }),
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
                      StreamBuilder(
                          stream: databaseService.exerciseReps,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<int>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: snapshot.data!
                                    .map((reps) => HomePageReps(reps: reps))
                                    .toList(),
                              );
                            } else {
                              return HomePageReps(reps: 0);
                            }
                          }),
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
                      StreamBuilder(
                          stream: databaseService.exerciseSets,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<int>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: snapshot.data!
                                    .map((sets) => HomePageSets(sets: sets))
                                    .toList(),
                              );
                            } else {
                              return HomePageSets(sets: 0);
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Column for buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: Column(
              children: [
                // Start Workout Button
                ElevatedButton(
                  onPressed: () {
                    databaseService.clearDatabase();
                    databaseService.notifyListeners();
                  },
                  child: const Text("Start Workout"),
                ),
                // Add Workout Button
                AddWorkout(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
