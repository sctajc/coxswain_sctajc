import 'package:flutter/material.dart';

class UserLevel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beginner'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'By default user is a beginner unless in settings has selected another level/program set'
                'At beginner level show a Beginners Training Plan'
                'as a PDF that can be printed or displayed'
                ''
                'If say HIIT a training plan for that'),
          ),
        ],
      ),
    );
  }
}
