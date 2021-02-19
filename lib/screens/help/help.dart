import 'package:get/get.dart';
import 'package:coxswain/screens/help/help_getting_started.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  child: Text(
                    'Getting started',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Getting Started',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Connecting to the Waterrower',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Connecting to the Waterrower',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Heart rate monitors',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Heart Rate Monitor',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Getting started',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Getting Started',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Connecting to the Waterrower',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Connecting to the Waterrower',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Heart rate monitors',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () => Get.to(
                    HelpGettingStarted(
                      helpAppBarHeading: 'Heart Rate Monitors',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
