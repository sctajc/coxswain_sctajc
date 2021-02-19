import 'package:flutter/material.dart';

class HelpGettingStarted extends StatelessWidget {
  final String helpAppBarHeading;
  HelpGettingStarted({this.helpAppBarHeading});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(helpAppBarHeading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    'Coxswain is very simple to start using. The only hardware you will need depends on how you wish to connect your Waterrower to Coxswain. '
                    'This can either be via a cable or by using Bluetooth. Bluetooth requires the special Waterrower Bluetooth addon available from Waterrower. See connection details here'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Coxswain is very simple to start using. The only hardware you will need depends on how you wish to connect your Waterrower to Coxswain. '
                    'This can either be via a cable or by using Bluetooth. Bluetooth requires the special Waterrower Bluetooth addon available from Waterrower. See connection details here'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Coxswain is very simple to start using. The only hardware you will need depends on how you wish to connect your Waterrower to Coxswain. '
                    'This can either be via a cable or by using Bluetooth. Bluetooth requires the special Waterrower Bluetooth addon available from Waterrower. See connection details here'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Coxswain is very simple to start using. The only hardware you will need depends on how you wish to connect your Waterrower to Coxswain. '
                    'This can either be via a cable or by using Bluetooth. Bluetooth requires the special Waterrower Bluetooth addon available from Waterrower. See connection details here'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Coxswain is very simple to start using. The only hardware you will need depends on how you wish to connect your Waterrower to Coxswain. '
                    'This can either be via a cable or by using Bluetooth. Bluetooth requires the special Waterrower Bluetooth addon available from Waterrower. See connection details here'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'All the defaults in Coxswain should be right for a beginner. It is suggested....'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
