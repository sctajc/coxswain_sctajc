import 'package:flutter/material.dart';

class ImportExport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import/Export'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'You may want to import or export Programs you have developed or Workouts '
                'you have completed. '
                'Do note that you can share a Program from the Programs screen for other users '
                'to use. A Program shared with you can be added by .... '
                'Workouts can be linked to Google Fit or Strada by selecting Yes in Settings.'
                ''),
            SizedBox(
              height: 10,
            ),
            Text('Workout files are in directory etc etc'),
          ],
        ),
      ),
    );
  }
}
