import 'package:coxswain/models/intensity.dart';
import 'package:coxswain/models/program.dart';
import 'package:coxswain/models/segment.dart';
import 'package:coxswain/models/to_complete.dart';
import 'package:coxswain/models/to_maintain.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:coxswain/shared/help_text_bottom_sheet.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

class ProgramAddEdit extends StatefulWidget {
  ProgramAddEdit({
    this.currentProgramKey = 0,
  });
  final int currentProgramKey;

  @override
  _ProgramAddEditState createState() => _ProgramAddEditState();
}

class _ProgramAddEditState extends State<ProgramAddEdit> {
  final _screenWidth = Get.width;

  final ToComplete toComplete = ToComplete.Duration;

  @override
  Widget build(BuildContext context) {
    final Box<Program> programBox = Hive.box<Program>(programBoxName);
    final Box<Segment> segmentBox = Hive.box<Segment>(segmentBoxName);
    final Box _userSettingsBox = Hive.box(userSettingsBoxName);

    int programIdToUse = 1; // default if first created program
    int nextSegmentIdToUse = 1;

    String appBarTitle = '';
    String programInitialName = '';
    if (widget.currentProgramKey == 0) {
      // add a new program
      appBarTitle = 'Add new program';
      programInitialName = '';
      //TODO better way to find max key value???
      if (programBox.length > 0) {
        // ie existing Programs
        programIdToUse = programBox.getAt(programBox.length - 1).key + 1;
        nextSegmentIdToUse = segmentBox.getAt(segmentBox.length - 1).key + 1;
      }
    } else {
      // edit an existing program
      appBarTitle = 'Edit program';
      programInitialName = programBox.get(widget.currentProgramKey).programName;
      programIdToUse = widget.currentProgramKey;
      nextSegmentIdToUse = segmentBox.getAt(segmentBox.length - 1).key + 1;
    }

    print('Number of Programs is ${programBox.length}');
    print('Number of Segments is ${segmentBox.length}');
    print('Program Id to use is $programIdToUse');
    print('Next Segment Id to use is $nextSegmentIdToUse');
    print('      ');

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: _screenWidth * 0.8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: TextFormField(
                    initialValue: programInitialName,
                    decoration: InputDecoration(
                      hintText: 'eg Steady 20 minutes',
                      labelText: 'Program Name',
                      labelStyle: TextStyle(
                        color: kColorBlue,
                      ),
                    ),
                    onChanged: (value) {
                      programBox.put(
                        programIdToUse,
                        Program(
                          programId: programIdToUse,
                          programName:
                              value, //programKeyToUse.toString(), //value,
                        ),
                      );

                      // if a new program - create the first segment as well
                      if (widget.currentProgramKey == 0) {
                        print('Adding new Segment');
                        print('Program key is $programIdToUse}');
                        print('Segment key is $nextSegmentIdToUse}');
                        segmentBox.put(
                          nextSegmentIdToUse,
                          Segment(
                            segmentId: nextSegmentIdToUse,
                            programId: programIdToUse,
                            intensity: Intensity.WarmUpBlue,
                            toComplete: ToComplete.Duration,
                            toMaintain: ToMaintain.None,
                            valueToComplete: 0,
                            valueToMaintain: 0,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              HelpTextBottomSheet(
                helpTextOne: 'Enter a Program name that\'s meaningful to you. ',
                helpTextTwo:
                    'Add as many segments as required. Often the first '
                    'segment is a warm up & the last is stretching. In between you may have '
                    'as many segments as you require. '
                    'Use copy icon to add another segment. '
                    'Use delete icon to delete a segment. '
                    'There must be at least one segment so you can not delete the last one. ',
              )
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Segment>(segmentBoxName).listenable(),
              builder: (context, Box<Segment> theSegment, _) {
                //TODO must be a better way of getting segment totals
                int segmentTotalForProgram = 0;
                for (int i = 0; i < segmentBox.length; i++) {
                  Segment currentSegment = segmentBox.getAt(i);
                  if (currentSegment.programId == programIdToUse) {
                    segmentTotalForProgram = segmentTotalForProgram + 1;
                  }
                }

                // if (theSegment.values.isEmpty) {
                if (segmentTotalForProgram < 1) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        '$segmentTotalForProgram - no segments. '
                        'No way should you get here. '
                        'Delete Program and start again',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: theSegment.values.length,
                  itemBuilder: (context, index) {
                    if (theSegment.getAt(index).programId == programIdToUse) {
                      int currentIndex = index;
                      int currentPropertyId = theSegment.getAt(index).programId;
                      int currentSequenceId = theSegment.getAt(index).segmentId;
                      int currentKey = theSegment.getAt(index).key;

                      return ListTile(
                        title: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        child: Icon(Icons.copy),
                                        onTap: () {
                                          // theSegment.add(
                                          theSegment.put(
                                            nextSegmentIdToUse,
                                            // theSegment.length + 1,
                                            Segment(
                                              segmentId: nextSegmentIdToUse,
                                              programId: programIdToUse,
                                              toComplete: ToComplete.Duration,
                                              valueToComplete: 10,
                                              toMaintain: ToMaintain.None,
                                              valueToMaintain: 5,
                                              intensity: Intensity.EasyGreen,
                                            ),
                                          );
                                          nextSegmentIdToUse += 1;
                                        },
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.delete),
                                        onTap: () {
                                          setState(() {
                                            if (segmentTotalForProgram > 1) {
                                              print(
                                                  'segment index $index deleted '
                                                  'SegId: $currentSequenceId, '
                                                  'ProgId: $currentPropertyId');
                                              theSegment.deleteAt(index);
                                            } else {
                                              print(
                                                  'Did not delete ${theSegment.getAt(index).programId},'
                                                  '${theSegment.getAt(index).segmentId}');
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            color: Colors.grey[300],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('20'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton<ToComplete>(
                                                underline: Container(
                                                  color: Colors.transparent,
                                                ),
                                                items:
                                                    ToCompleteString.keys.map(
                                                  (ToComplete value) {
                                                    return DropdownMenuItem<
                                                        ToComplete>(
                                                      value: value,
                                                      child: Text(
                                                        ToCompleteString[value],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                                value: toComplete,
                                                onChanged: (value) {
                                                  // _userSettingsBox.put(value)
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            color: Colors.grey[300],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('120'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 8),
                                              child: Text('Power'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: SizedBox(
                                      width: 40,
                                      child: Container(
                                        height: 70,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'PropId $currentPropertyId, '
                              'segmId: $currentSequenceId, '
                              'key: $currentKey, '
                              'index: $currentIndex',
                            ),
                          ],
                        ),
                      );
                      //TODO Must be a cleaner approach
                    } else {
                      return SizedBox(
                        height: 0,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  listOptions(
    List<String> _options,
    int _selectedInitialValue,
    String _optionHeading,
    String _databaseFieldName,
    String _helpLineOne,
    String _helpLineTwo,
    var context,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: _getShadowDecoration(),
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(
                    _optionHeading,
                    style: kFieldHeading,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  child: Container(
                    color: Colors.blueGrey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: DirectSelectList<String>(
                        values: _options,
                        onUserTappedListener: () => _showScaffold(
                          context,
                        ),
                        defaultItemIndex: _selectedInitialValue,
                        itemBuilder: (String value) =>
                            getDropDownMenuItem(value),
                        focusedItemDecoration: _getDslDecoration(),
                        onItemSelectedListener: (item, index, context) {
                          FocusScope.of(context).unfocus(); // dismiss keyboard
                          // _userSettingsBox.put(_databaseFieldName, index);
                        },
                      ),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: _getDropdownIcon(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: HelpTextBottomSheet(
                  helpTextOne: _helpLineOne,
                  helpTextTwo: _helpLineTwo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  void _showScaffold(
    var context,
  ) {
    FocusScope.of(context).unfocus(); // dismiss keyboard
    Get.snackbar('Hold instead of tap', "then make your choice",
        snackPosition: SnackPosition.BOTTOM);
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.blueAccent,
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }
}
