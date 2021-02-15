import 'package:coxswain/models/program.dart';
import 'package:coxswain/models/segment.dart';
import 'package:coxswain/screens/programs/program_add_edit.dart';
import 'package:coxswain/screens/user_settings/user_settings.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgramList extends StatelessWidget {
  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    Box<Program> programBox = Hive.box<Program>(programBoxName);
    Box<Segment> segmentBox = Hive.box<Segment>(segmentBoxName);

    // print('ProgramList - Total Programs: ${programBox.length}');
    // print('ProgramList - Total Segments: ${segmentBox.length}');

    // programBox.values.where((item) => item.programId > 0).forEach(
    //   (item) {
    //     print(
    //       'program Id ${item.programId} - ${item.programName}',
    //     );
    //   },
    // );
    print('    ');

    segmentBox.values.where((item) => item.programId > 0).forEach(
      (item) {
        print(
          'prog Id ${item.programId} - seg ${item.segmentId}, key ${item.key},}',
        );
      },
    );
    print('    ');

    // programBox.clear();
    // segmentBox.clear();
    // segmentBox.delete(21);

    int programKeyToUse = 0;
    if (programBox.length > 0) {
      programKeyToUse = programBox.getAt(programBox.length - 1).key + 1;
    }

    // int programKeyToUse = programBox.getAt(programBox.length - 1).key + 1;
    // print('screen width: $screenWidth');
    return ValueListenableBuilder(
      valueListenable: Hive.box<Program>(programBoxName).listenable(),
      builder: (context, Box<Program> theProgram, _) {
        if (theProgram.values.isEmpty)
          return Center(
            child: Text("${theProgram.values.length} - no programs"),
          );
        return ListView.builder(
          itemCount: theProgram.values.length,
          itemBuilder: (context, index) {
            Program currentProgram = theProgram.getAt(index);
            // print('current program: ${currentProgram.programName}');

            //TODO must be a better way of getting segment totals
            int segmentTotalForProgram = 0;
            for (int i = 0; i < segmentBox.length; i++) {
              Segment currentSegment = segmentBox.getAt(i);
              if (currentSegment.programId == currentProgram.programId) {
                segmentTotalForProgram += 1;
              }
            }
            print(
              'For Program ${currentProgram.programId} segment total: $segmentTotalForProgram',
            );

            return ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: screenWidth * .45,
                    child: Text(
                      '${currentProgram.programName}',
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
              ),
              subtitle: Column(
                children: [
                  Row(
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
                  Row(
                    children: [
                      Text('Prog Id: ${currentProgram.programId},'
                          ' segments: $segmentTotalForProgram'
                          ' key: ${currentProgram.key}, index: $index,'),
                    ],
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
                            ProgramAddEdit(
                              currentProgramKey: currentProgram.key,
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
                          programBox.add(
                            Program(
                                programId: programKeyToUse,
                                programName:
                                    '${currentProgram.programName} - Duplicate'),
                          );
                          Get.back();
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                        child: Text('Delete'),
                        onPressed: () {
                          currentProgram.delete();
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
