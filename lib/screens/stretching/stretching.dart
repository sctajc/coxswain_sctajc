import 'package:coxswain/shared/constants.dart';
import 'package:flutter/material.dart';

class Stretching extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stretching'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'The Importance of Stretching after exercising',
              style: TextStyle(color: kColorOrange),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Depending on your routine you may want to stretch before and/or after a workout. '
              'Your program may include a gentle first segment of 5 minutes rowing, '
              'a segment (or segments) of working out, then stretches for the last segment. ',
            ),
            SizedBox(
              height: 10,
            ),
            Text("Display or link to the Waterrower's Water Coach pdf"),
          ],
        ),
      ),
    );
  }
}
