import 'package:flutter/material.dart';
import 'package:gymbro/backend/database/database_services.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final DatabaseService databaseService = DatabaseService.instance;
  String workoutName = "";
  String type = "";
  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  bool enableButton = false;

  @override
  void initState() {
    super.initState();
    workoutNameController.addListener(() {
      workoutName = workoutNameController.text;
      enableButton = workoutNameController.text.isNotEmpty &&
          typeController.text.isNotEmpty;
      setState(() {
        enableButton = enableButton;
      });
    });
    typeController.addListener(() {
      type = typeController.text;
      enableButton = workoutNameController.text.isNotEmpty &&
          typeController.text.isNotEmpty;
      setState(() {
        enableButton = enableButton;
      });
    });
  }

  @override
  void dispose() {
    workoutNameController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text("Add Workout"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: workoutNameController,
                      onChanged: (value) {
                        setState(() {
                          enableButton =
                              workoutNameController.text.isNotEmpty &&
                                  typeController.text.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Workout Name",
                        hintText: "Bench Press, Squats, etc.",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextField(
                      controller: typeController,
                      onChanged: (value) {
                        setState(() {
                          enableButton =
                              workoutNameController.text.isNotEmpty &&
                                  typeController.text.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Type",
                        hintText: "Push, Pull, Legs",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    MaterialButton(
                      onPressed: enableButton
                          ? () async {
                              // Get currentDay of first exercise
                              int currentDay =
                                  await databaseService.getFirstExerciseDay();
                              if (currentDay == 0) {
                                currentDay = 1;
                              }
                              // Add workout to database
                              // databaseService.addExercise(
                              //     workoutName, 0, 0, 0, type, currentDay);
                              setState(() {
                                enableButton = false;
                                workoutNameController.clear();
                                typeController.clear();
                              });
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text("Add Workout"),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
      child: const Text("Add Workout"),
    );
  }
}
