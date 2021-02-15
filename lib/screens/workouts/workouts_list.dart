import 'package:coxswain/screens/user_settings/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutList extends StatelessWidget {
  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Programs code here temporary until this developed',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.45,
                  child: Text(
                    'Steady 20 minutes',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Text(
                    '28 minutes',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ), //,
            subtitle: Row(
              children: [
                Container(
                  color: Colors.blue,
                  width: screenWidth * .10,
                  height: 17,
                ),
                Container(
                  width: screenWidth * .45,
                  height: 17,
                  color: Colors.orange,
                ),
                Container(
                  width: screenWidth * .15,
                  height: 17,
                  color: Colors.purple,
                ),
              ],
            ),
            onTap: () {},
            trailing: PopupMenuButton(
              color: Colors.blue[300],
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Select'),
                      onPressed: () {},
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Edit'),
                      onPressed: () {
                        Get.off(
                          UserSettings(),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Share'),
                      onPressed: () {},
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Duplicate'),
                      onPressed: () {},
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      child: Text('Delete'),
                      onPressed: () {},
                    ),
                  ),
                ];
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.45,
                  child: Text(
                    'Segments 4km',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Text(
                    '22 minutes',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ), //,
            subtitle: Row(
              children: [
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.blue,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.yellow,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.orange,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.green,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.orange,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.yellow,
                ),
                Container(
                  width: screenWidth * .1,
                  height: 17,
                  color: Colors.purple,
                ),
              ],
            ),
            onTap: () {},
            trailing: PopupMenuButton(
              color: Colors.blue[300],
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Select'),
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Edit'),
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Share'),
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Duplicate'),
                    ),
                  ),
                  PopupMenuItem(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Delete'),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
