import 'package:coxswain/screens/user_settings/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutList extends StatelessWidget {
  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Your Completed Workouts')),
    );
  }
}
