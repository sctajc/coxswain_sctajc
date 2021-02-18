import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkoutScreen extends StatelessWidget {
  final _screenWidth = Get.width;
  final _screenHeight = Get.height - 125;
  final TextStyle _numberTextStyle = TextStyle(fontSize: 70);
  final TextStyle _textTextStyle = TextStyle(fontSize: 20);
  final double _intensityWidth = 30;

  final _displayWorkoutNumber = NumberFormat('###,###');

  // sample variables values
  // these values need to feed from Waterrower!!!
  int _durationMinutes = 20;
  int _durationSeconds = 16;
  int _distance = 3500;
  int _strokes = 477;
  double _speed = 4.76;
  int _power = 45;
  int _strokeRate = 24;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Working Out!!'),
          elevation: 10,
          actions: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: _intensityWidth,
                        height: .1 * _screenHeight,
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: _intensityWidth,
                        height: .2 * _screenHeight,
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: _intensityWidth,
                        height: .3 * _screenHeight,
                        child: Container(
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: _intensityWidth,
                        height: .3 * _screenHeight,
                        child: Container(
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: _intensityWidth,
                        height: .1 * _screenHeight,
                        child: Container(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _screenWidth - _intensityWidth,
                      ),
                      Text(
                        '$_durationMinutes:$_durationSeconds',
                        // '22:54',
                        style: _numberTextStyle,
                      ),
                      Text('Duration (minutes left)'),
                      Text(
                        _displayWorkoutNumber.format(_distance),
                        style: _numberTextStyle,
                      ),
                      Text(
                        'Distance (meters)',
                        style: _textTextStyle,
                      ),
                      Text(
                        _displayWorkoutNumber.format(_strokes),
                        style: _numberTextStyle,
                      ),
                      Text(
                        'Strokes',
                        style: _textTextStyle,
                      ),
                      Text(
                        _displayWorkoutNumber.format(_speed),
                        style: _numberTextStyle,
                      ),
                      Text(
                        'Speed (minutes/500m)',
                        style: _textTextStyle,
                      ),
                      Text(
                        _displayWorkoutNumber.format(_power),
                        style: _numberTextStyle,
                      ),
                      Text(
                        'Power (watts)',
                        style: _textTextStyle,
                      ),
                      Text(
                        _displayWorkoutNumber.format(_strokeRate),
                        style: _numberTextStyle,
                      ),
                      Text(
                        'Stroke Rate (per minute)',
                        style: _textTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
