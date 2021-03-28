import 'package:coxswain/models/intensity.dart';
import 'package:coxswain/models/program.dart';
import 'package:coxswain/models/segment.dart';
import 'package:coxswain/models/to_complete.dart';
import 'package:coxswain/models/to_maintain.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:coxswain/shared/help_text_bottom_sheet.dart';
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
  bool _startedEnteringProgramName = false;

  @override
  Widget build(BuildContext context) {
    final Box<Program> _programBox = Hive.box<Program>(programBoxName);
    final Box<Segment> _segmentBox = Hive.box<Segment>(segmentBoxName);

    int _programIdToUse = 1; // default if first created program

    // for when creating a new program and editing it's newly created segment(s) at the same time
    int _nextSegmentIdToUse = 1;
    bool _autoFocusOnProgramName = false;

    String _appBarTitle = '';
    String _programInitialName = '';
    if (widget.currentProgramKey == 0) {
      // ie create a new program
      _appBarTitle = 'Add new program';
      _programInitialName = '';
      _autoFocusOnProgramName = true;

      if (_programBox.length < 1) {
        // ie no other programs already exist (this new program is the first one)
        _programIdToUse = 1;
        _nextSegmentIdToUse = 1;
      } else {
        // if editing a segment while still adding a new program, don't increase _programIdToUse
        if (_startedEnteringProgramName) {
          _programIdToUse = _programBox.getAt(_programBox.length - 1)!.key;
        } else {
          _programIdToUse = _programBox.getAt(_programBox.length - 1)!.key + 1;
        }
        _nextSegmentIdToUse = _segmentBox.getAt(_segmentBox.length - 1)!.key + 1;
        // print('did add 1: ${_programBox.getAt(_programBox.length - 1).key}');
      }
    } else {
      // edit an existing program
      _appBarTitle = 'Edit program';
      _programInitialName = _programBox.get(widget.currentProgramKey)!.programName;
      _programIdToUse = widget.currentProgramKey;
      _nextSegmentIdToUse = _segmentBox.getAt(_segmentBox.length - 1)!.key + 1;
    }

    Color segmentIntensityColor = Colors.green;

    print('Number of Programs is ${_programBox.length}');
    print('Number of Segments is ${_segmentBox.length}');
    print('Program Id to use is $_programIdToUse');
    print('Next Segment Id to use is $_nextSegmentIdToUse');
    print('      ');

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Get.snackbar('Share program', 'With someone else',
                    snackPosition: SnackPosition.BOTTOM);
              })
        ],
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
                    autofocus: _autoFocusOnProgramName,
                    initialValue: _programInitialName,
                    decoration: InputDecoration(
                      hintText: 'eg Steady 20 minutes',
                      labelText: 'Program Name',
                      labelStyle: TextStyle(
                        color: kColorBlue,
                      ),
                    ),
                    onChanged: (value) {
                      _startedEnteringProgramName = true;
                      print('Adding new program with program Id: $_programIdToUse');
                      _programBox.put(
                        _programIdToUse,
                        Program(
                          programId: _programIdToUse,
                          programName: value,
                        ),
                      );

                      // if a new program - create the first segment as well
                      if (widget.currentProgramKey == 0) {
                        print(
                            'Adding new Segment - Program Id is $_programIdToUse, Segment Id is $_nextSegmentIdToUse');
                        _segmentBox.put(
                          _nextSegmentIdToUse,
                          Segment(
                            segmentId: _nextSegmentIdToUse,
                            programId: _programIdToUse,
                            intensity: Intensity.WarmUpBlue,
                            toComplete: ToComplete.Duration,
                            toMaintain: ToMaintain.None,
                            valueToComplete: 15,
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
                helpTextTwo: 'Add as many segments as required. Often the first '
                    'segment is a warm up & the last is stretching. In between you may have '
                    'as many segments as you require. '
                    'Use + to add another segment. '
                    'Use delete icon to delete a segment. '
                    'There must be at least one segment. ',
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Scrollbar(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Segment>(segmentBoxName).listenable(),
                builder: (context, Box<Segment> _theSegment, _) {
                  Icon deleteIconToDisplay = Icon(Icons.delete);

                  int _segmentTotalForProgram = 0;
                  _segmentBox.values
                      .where((element) => element.programId == _programIdToUse)
                      .forEach((element) {
                    _segmentTotalForProgram += 1;
                  });

                  return ListView.builder(
                    // return ReorderableListView.builder(
                    //   onReorder: (oldIndex, newIndex) {
                    //   // TODO get segments to save reorder
                    //   setState(() {
                    //     // _updateMyItems(oldIndex, newIndex);
                    //     if (oldIndex < newIndex) {
                    //       newIndex -= 1;
                    //     }
                    //   });
                    //  },
                    shrinkWrap: true,
                    itemCount: _theSegment.values.length,
                    itemBuilder: (context, index) {
                      if (_segmentTotalForProgram < 2) {
                        deleteIconToDisplay = Icon(Icons.delete_outline);
                      }

                      // print(
                      //     '_theSegment.getAt(index).programId: ${_theSegment.getAt(index).programId}');
                      // print('_theSegment.getAt(index).key: ${_theSegment.getAt(index).key}');

                      if (_theSegment.getAt(index)!.programId == _programIdToUse) {
                        int currentIndex = index;
                        int currentPropertyId = _theSegment.getAt(index)!.programId;
                        int currentSequenceId = _theSegment.getAt(index)!.segmentId;
                        int currentKey = _theSegment.getAt(index)!.key;
                        ToComplete currentToComplete = _theSegment.getAt(index)!.toComplete;
                        int currentValueToComplete = _theSegment.getAt(index)!.valueToComplete;
                        ToMaintain currentToMaintain = _theSegment.getAt(index)!.toMaintain;
                        int currentValueToMaintain = _theSegment.getAt(index)!.valueToMaintain;
                        if (currentToMaintain == ToMaintain.None) {
                          currentValueToMaintain = 0;
                        }
                        Intensity currentIntensity = _theSegment.getAt(index)!.intensity;
                        switch (currentIntensity) {
                          case Intensity.WarmUpBlue:
                            {
                              segmentIntensityColor = Colors.blue;
                            }
                            break;

                          case Intensity.EasyGreen:
                            {
                              segmentIntensityColor = Colors.greenAccent;
                            }
                            break;

                          case Intensity.MediumYellow:
                            {
                              segmentIntensityColor = Colors.yellowAccent;
                            }
                            break;
                          case Intensity.HardOrange:
                            {
                              segmentIntensityColor = Colors.deepOrangeAccent;
                            }
                            break;
                          case Intensity.CoolDownGrey:
                            {
                              segmentIntensityColor = Colors.blueGrey;
                            }
                            break;

                          case Intensity.StretchingPurple:
                            {
                              segmentIntensityColor = Colors.purple;
                            }
                            break;

                          case Intensity.RestWhite:
                            {
                              segmentIntensityColor = Colors.white;
                            }
                            break;
                        }

                        return ReorderableDragStartListener(
                          key: ValueKey(index),
                          index: index,
                          child: ListTile(
                            key: ValueKey(index),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 1, 0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Container(
                                                alignment: Alignment.bottomLeft,
                                                color: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    initialValue: currentValueToComplete.toString(),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          currentValueToComplete = int.parse(value);
                                                          _theSegment.put(
                                                              currentKey,
                                                              Segment(
                                                                programId: currentPropertyId,
                                                                segmentId: currentSequenceId,
                                                                toComplete: currentToComplete,
                                                                valueToComplete:
                                                                    currentValueToComplete,
                                                                toMaintain: currentToMaintain,
                                                                valueToMaintain:
                                                                    currentValueToMaintain,
                                                                intensity: currentIntensity,
                                                              ));
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),

                                            // To complete drop down
                                            SizedBox(
                                              width: 120,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: DropdownButton<ToComplete>(
                                                    underline: Container(color: Colors.transparent),
                                                    items: ToCompleteString.keys.map(
                                                      (ToComplete value) {
                                                        return DropdownMenuItem<ToComplete>(
                                                          value: value,
                                                          child: Text(
                                                            ToCompleteString[value]!,
                                                            style: TextStyle(fontSize: 12),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                    value: currentToComplete,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        currentToComplete = value!;
                                                        _theSegment.put(
                                                          currentKey,
                                                          Segment(
                                                            programId: currentPropertyId,
                                                            segmentId: currentSequenceId,
                                                            toComplete: currentToComplete,
                                                            valueToComplete: currentValueToComplete,
                                                            toMaintain: currentToMaintain,
                                                            valueToMaintain: currentValueToMaintain,
                                                            intensity: currentIntensity,
                                                          ),
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Container(
                                                color: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                                  child: TextFormField(
                                                      keyboardType: TextInputType.number,
                                                      initialValue:
                                                          currentValueToMaintain.toString(),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        if (currentToMaintain == ToMaintain.None) {
                                                          value = 0.toString();
                                                        }
                                                        setState(() {
                                                          currentValueToMaintain = int.parse(value);
                                                          _theSegment.put(
                                                              currentKey,
                                                              Segment(
                                                                programId: currentPropertyId,
                                                                segmentId: currentSequenceId,
                                                                toComplete: currentToComplete,
                                                                valueToComplete:
                                                                    currentValueToComplete,
                                                                toMaintain: currentToMaintain,
                                                                valueToMaintain:
                                                                    currentValueToMaintain,
                                                                intensity: currentIntensity,
                                                              ));
                                                        });
                                                      }),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: DropdownButton<ToMaintain>(
                                                    underline: Container(color: Colors.transparent),
                                                    items: ToMaintainString.keys.map(
                                                      (ToMaintain value) {
                                                        return DropdownMenuItem<ToMaintain>(
                                                          value: value,
                                                          child: Text(
                                                            ToMaintainString[value]!,
                                                            style: TextStyle(fontSize: 12),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                    value: currentToMaintain,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        currentToMaintain = value!;
                                                        _theSegment.put(
                                                          currentKey,
                                                          Segment(
                                                            programId: currentPropertyId,
                                                            segmentId: currentSequenceId,
                                                            toComplete: currentToComplete,
                                                            valueToComplete: currentValueToComplete,
                                                            toMaintain: currentToMaintain,
                                                            valueToMaintain: currentValueToMaintain,
                                                            intensity: currentIntensity,
                                                          ),
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: deleteIconToDisplay,
                                            onTap: () {
                                              setState(() {
                                                if (_segmentTotalForProgram > 1) {
                                                  _theSegment.deleteAt(index);
                                                } else {
                                                  Get.snackbar('Can not delete this segment. ',
                                                      'A Program requires at least one Segment. ',
                                                      snackPosition: SnackPosition.BOTTOM);
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Icon(Icons.drag_handle),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: SizedBox(
                                    width: 241,
                                    child: Container(
                                      color: segmentIntensityColor,
                                      height: 40,
                                      // color: Colors.orange,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                                        child: DropdownButton<Intensity>(
                                          underline: Container(color: Colors.transparent),
                                          items: IntensityString.keys.map(
                                            (Intensity value) {
                                              return DropdownMenuItem<Intensity>(
                                                value: value,
                                                child: Text(
                                                  IntensityString[value]!,
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          value: currentIntensity,
                                          onChanged: (value) {
                                            setState(() {
                                              currentIntensity = value!;
                                              _theSegment.put(
                                                currentKey,
                                                Segment(
                                                  programId: currentPropertyId,
                                                  segmentId: currentSequenceId,
                                                  toComplete: currentToComplete,
                                                  valueToComplete: currentValueToComplete,
                                                  toMaintain: currentToMaintain,
                                                  valueToMaintain: currentValueToMaintain,
                                                  intensity: currentIntensity,
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'PropId $currentPropertyId, '
                                    'segmId: $currentSequenceId, '
                                    'key: $currentKey, '
                                    'index: $currentIndex',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        //TODO Must be a cleaner approach
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          _segmentBox.put(
            _nextSegmentIdToUse,
            Segment(
              segmentId: _nextSegmentIdToUse,
              programId: _programIdToUse,
              toComplete: ToComplete.Duration,
              valueToComplete: 10,
              toMaintain: ToMaintain.None,
              valueToMaintain: 0,
              intensity: Intensity.EasyGreen,
            ),
          );
          _nextSegmentIdToUse += 1;
        },
      ),
    );
  }
}
