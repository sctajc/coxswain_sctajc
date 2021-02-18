import 'package:coxswain/models/program.dart';
import 'package:coxswain/models/segment.dart';
import 'package:coxswain/screens/programs/program_add_edit.dart';
import 'package:coxswain/screens/workouts/workout_screen.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgramList extends StatelessWidget {
  final _screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    Box<Program> _programBox = Hive.box<Program>(programBoxName);
    Box<Segment> _segmentBox = Hive.box<Segment>(segmentBoxName);

    print('Existing programs');
    _programBox.values.where((item) => item.programId > 0).forEach(
      (item) {
        print(
          'program Id ${item.programId} - name: ${item.programName}',
        );
      },
    );
    print('    ');
    print('Existing segments');
    _segmentBox.values.where((item) => item.programId > 0).forEach(
      (item) {
        print(
          'prog Id ${item.programId} - seg ${item.segmentId}, key ${item.key},}',
        );
      },
    );
    print('    ');

    // _programBox.clear();
    // _segmentBox.clear();
    // _segmentBox.delete(21);

    int _programKeyToUse = 0;
    if (_programBox.length > 0) {
      _programKeyToUse = _programBox.getAt(_programBox.length - 1).key + 1;
    }

    // int _programKeyToUse = _programBox.getAt(_programBox.length - 1).key + 1;
    // print('screen width: $screenWidth');
    return ValueListenableBuilder(
      valueListenable: Hive.box<Program>(programBoxName).listenable(),
      builder: (context, Box<Program> _theProgram, _) {
        if (_theProgram.values.isEmpty)
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "You have no Programs. Hit the plus below to enter a program",
                style: TextStyle(
                  color: kColorBlue,
                ),
              ),
            ),
          );
        return ListView.builder(
          itemCount: _theProgram.values.length,
          itemBuilder: (context, _index) {
            Program _currentProgram = _theProgram.getAt(_index);

            int _segmentTotalForProgram = 0;
            _segmentBox.values
                .where((element) => element.programId == _currentProgram.programId)
                .forEach((element) {
              _segmentTotalForProgram += 1;
            });
            print(
              'For Program ${_currentProgram.programId} segment total: $_segmentTotalForProgram',
            );

            return ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: _screenWidth * .45,
                    child: Text(
                      '${_currentProgram.programName}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: _screenWidth * 0.25,
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
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blue,
                        width: _screenWidth * .10,
                        height: 17,
                      ),
                      Container(
                        width: _screenWidth * .45,
                        height: 17,
                        color: Colors.orange,
                      ),
                      Container(
                        width: _screenWidth * .15,
                        height: 17,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Prog Id: ${_currentProgram.programId},'
                        ' segments: $_segmentTotalForProgram'
                        ' key: ${_currentProgram.key}, index: $_index,',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Get.to(
                  WorkoutScreen(),
                );
              },
              trailing: PopupMenuButton(
                color: Colors.blue[300],
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Select'),
                        onPressed: () {
                          Get.off(
                            WorkoutScreen(),
                          );
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Edit'),
                        onPressed: () {
                          Get.off(
                            ProgramAddEdit(
                              currentProgramKey: _currentProgram.key,
                            ),
                          );
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Share'),
                        onPressed: () {
                          Get.snackbar(
                            'Share your program with others via email?',
                            'One day will be possible',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Duplicate'),
                        onPressed: () {
                          _programBox.add(
                            Program(
                                programId: _programKeyToUse,
                                programName: '${_currentProgram.programName} - Duplicate'),
                          );
                          Get.back();
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Delete'),
                        onPressed: () {
                          _currentProgram.delete();
                          _segmentBox.values
                              .where((element) => element.programId == _currentProgram.programId)
                              .forEach((element) => element.delete());

                          Get.back();
                        },
                      ),
                    ),
                  ];
                },
              ),
            );
          },
        );
      },
    );
  }
}
