import 'package:coxswain/controllers/settings_user_weight_controller.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:coxswain/shared/help_text_bottom_sheet.dart';
import 'package:coxswain/shared/yes_no_option.dart';

class UserSettings extends StatelessWidget {
  final _screenWidth = Get.width;
  final Box _userSettingsBox = Hive.box(userSettingsBoxName);

  // TODO controllers not being used but need to understand how they work
  final SettingsUserWeightController settingsUserWeightController =
      Get.put(SettingsUserWeightController());

  @override
  Widget build(BuildContext context) {
    // assign user's preselected choice (or assign a default value)
    var _selectedUserName = _userSettingsBox.get(kFieldUserName) ?? '';
    var _selectedUserWeight = _userSettingsBox.get(kFieldUserWeight) ?? 70;
    var _selectedWeight = _userSettingsBox.get(kFieldWeight) ?? 0; // 0 = Kg, 1 = pounds
    var _selectedAdjustEnergyToBodyWeight =
        _userSettingsBox.get(kFieldAdjustEnergyToBodyWeight) ?? 1;
    var _selectedDistance = _userSettingsBox.get(kFieldDistance) ?? 0;
    var _selectedEnergy = _userSettingsBox.get(kFieldEnergy) ?? 0;
    var _selectedSpeed = _userSettingsBox.get(kFieldSpeed) ?? 0;
    var _selectedProgramLevel = _userSettingsBox.get(kFieldProgramLevel) ?? 0;
    var _selectedKeepRowing = _userSettingsBox.get(kFieldKeepRowing) ?? 1;
    var _selectedAdjustSpeed = _userSettingsBox.get(kFieldAdjustSpeed) ?? 1;
    var _selectedLinkToFit = _userSettingsBox.get(kFieldLinkToFit) ?? 1;
    var _selectedLinkToStrada = _userSettingsBox.get(kFieldLinkToStrada) ?? 1;
    var _selectedExportWorkout = _userSettingsBox.get(kFieldExportWorkout) ?? 1;
    var _selectedStartURL = _userSettingsBox.get(kFieldStartURL) ?? 1;
    var _selectedStartActualURL = _userSettingsBox.get(kFieldStartActualURL) ??
        'https://www.youtube.com/playlist?list=WL&playnext=1';
    var _selectedSegmentInstruction = _userSettingsBox.get(kFieldSegmentInstruction) ?? 0;
    var _selectedSegmentSound = _userSettingsBox.get(kFieldSegmentSound) ?? 0;
    var _selectedWriteLog = _userSettingsBox.get(kFieldWriteLog) ?? 1;
    var _selectedWriteTrace = _userSettingsBox.get(kFieldWriteTrace) ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DirectSelectContainer(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Name',
                          style: kFieldHeading,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: _screenWidth * .5,
                        child: TextFormField(
                          initialValue: _selectedUserName,
                          decoration: InputDecoration(
                            hintText: 'eg Vincent van Gogh',
                            labelText: 'Your Coxswain Name',
                            labelStyle: TextStyle(
                              color: kColorBlue,
                            ),
                          ),
                          onChanged: (value) => _userSettingsBox.put(kFieldUserName, value),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      HelpTextBottomSheet(
                        helpTextOne:
                            'The name other Coxswain rowers will know you by if you share your workouts.',
                        helpTextTwo: 'Just for a bit of fun.',
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: kColorOrange,
                      border: Border.all(
                        color: kColorOrange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Column(
                        children: [
                          Container(
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
                                        'Weight',
                                        style: kFieldHeading,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: _selectedUserWeight.toString(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        counterText: '',
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // FocusScope.of(context).unfocus();
                                        _userSettingsBox.put(kFieldUserWeight, value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: ToggleSwitch(
                                        minWidth: 45,
                                        initialLabelIndex: _selectedWeight,
                                        labels: ['kg', 'lb'],
                                        onToggle: (index) {
                                          FocusScope.of(context).unfocus(); // dismiss keyboard
                                          _userSettingsBox.put(kFieldWeight, index);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          YesNoOption(
                              userSettingsBox: _userSettingsBox,
                              optionHeading: 'Adjust Energy',
                              selectedInitialValue: _selectedAdjustEnergyToBodyWeight,
                              databaseFieldName: kFieldAdjustEnergyToBodyWeight,
                              helpLineOne:
                                  'Your body weight is only used to improve energy and power accuracy. '
                                  'This may increase the accuracy by 10% ??? '
                                  'It is not passed to Google Fit ???  '
                                  'The Energy you use for a workout will be estimated more accurately if body weight is included. '
                                  'These are calculated by bla bla bla',
                              helpLineTwo: 'Ensure your body weight is entered accurately. ',
                              context: context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Measurement:',
                    style: kHeading,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  listOptions(
                    optionsDistance,
                    _selectedDistance,
                    'Distance',
                    kFieldDistance,
                    'Choose the measurement type for distance you row',
                    'Do you work in meters, miles or whatever',
                    context,
                  ),
                  listOptions(
                    optionsEnergy,
                    _selectedEnergy,
                    'Energy',
                    kFieldEnergy,
                    'Energy is a measure of the effort since the start of the workout. For example how many calories did you use for a workout',
                    'Not to confuse with Power which for example is the Energy used per stroke (or per minute)',
                    context,
                  ),
                  listOptions(
                    optionsSpeedPace,
                    _selectedSpeed,
                    'Speed/Pace',
                    kFieldSpeed,
                    'How fast are you going',
                    'or time taken to travel a certain distance',
                    context,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Training:',
                    style: kHeading,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  listOptions(
                    optionsProgramLevel,
                    _selectedProgramLevel,
                    'Program Level',
                    kFieldProgramLevel,
                    'If new to rowing start with beginners then... Have a look in Settings at the beginners page',
                    'If changing levels, default programs will be added to existing programs.',
                    context,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: kColorOrange,
                      border: Border.all(
                        color: kColorOrange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            YesNoOption(
                                userSettingsBox: _userSettingsBox,
                                optionHeading: 'Auto Start',
                                selectedInitialValue: _selectedStartURL,
                                databaseFieldName: kFieldStartURL,
                                helpLineOne:
                                    'When you start a workout program do you also want YouTube (or whatever) to automatically start for your watching or music pleasure?',
                                helpLineTwo:
                                    'The default URL will get you started but edit the URL whatever you wish.',
                                context: context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    'URL',
                                    style: kFieldHeading,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                SizedBox(
                                  width: _screenWidth * .7,
                                  child: TextFormField(
                                    onTap: () => _userSettingsBox.put(kFieldStartActualURL,
                                        'https://www.youtube.com/playlist?list=WL&playnext=1'),
                                    initialValue: _selectedStartActualURL,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText:
                                          'https://www.youtube.com/playlist?list=WL&playnext=1',
                                      labelStyle: TextStyle(
                                        color: kColorBlue,
                                      ),
                                    ),
                                    onChanged: (value) =>
                                        _userSettingsBox.put(kFieldStartActualURL, value),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Keep rowing',
                      selectedInitialValue: _selectedKeepRowing,
                      databaseFieldName: kFieldKeepRowing,
                      helpLineOne: 'Keep recording your workout even if the Program has completed.',
                      helpLineTwo: 'You can always row more!',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Adjust Speed',
                      selectedInitialValue: _selectedAdjustSpeed,
                      databaseFieldName: kFieldAdjustSpeed,
                      helpLineOne:
                          'Calculate your Speed from your Power rather than accept the speed supplied by your Waterrower',
                      helpLineTwo:
                          'This is considered more accurate than using Waterrower values, but then obviously the both values will not match.',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Link to Fit',
                      selectedInitialValue: _selectedLinkToFit,
                      databaseFieldName: kFieldLinkToFit,
                      helpLineOne: 'After every workout automatically update your Fit records.',
                      helpLineTwo:
                          'You need to give permission to link to Fit. Select Yes to start the process. You can always select No to unlink.',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Link to Strada',
                      selectedInitialValue: _selectedLinkToStrada,
                      databaseFieldName: kFieldLinkToStrada,
                      helpLineOne: 'After every workout automatically update your Strada records.',
                      helpLineTwo:
                          'You need to give permission to link to Strada. Select Yes to start the process. You can always select No to unlink.',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Export workout',
                      selectedInitialValue: _selectedExportWorkout,
                      databaseFieldName: kFieldExportWorkout,
                      helpLineOne:
                          'Export you workout (a .tcx file) automatically after every workout.',
                      helpLineTwo: 'File will be exported to /coxswain/workout/????.tcx',
                      context: context),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Audio:',
                    style: kHeading,
                  ),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Sound',
                      selectedInitialValue: _selectedSegmentSound,
                      databaseFieldName: kFieldSegmentSound,
                      helpLineOne: 'Play a sound at the start of each Workout Segment.',
                      helpLineTwo: 'You may just want voice instructions for each segment change.',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Voice',
                      selectedInitialValue: _selectedSegmentInstruction,
                      databaseFieldName: kFieldSegmentInstruction,
                      helpLineOne: 'Give voice instructions at the start of each Program Segment.',
                      helpLineTwo: 'You may just prefer a sound for each segment change',
                      context: context),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Other:',
                    style: kHeading,
                  ),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Log',
                      selectedInitialValue: _selectedWriteLog,
                      databaseFieldName: kFieldWriteLog,
                      helpLineOne: 'Only for diagnostic purposes',
                      helpLineTwo: 'You maybe asked to turn this on if receiving technical support',
                      context: context),
                  YesNoOption(
                      userSettingsBox: _userSettingsBox,
                      optionHeading: 'Trace',
                      selectedInitialValue: _selectedWriteTrace,
                      databaseFieldName: kFieldWriteTrace,
                      helpLineOne: 'Only for diagnostic purposes',
                      helpLineTwo: 'You maybe asked to turn this on if receiving technical support',
                      context: context),
                ],
              ),
            ),
          ),
        ),
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
                        itemBuilder: (String value) => getDropDownMenuItem(value),
                        focusedItemDecoration: _getDslDecoration(),
                        onItemSelectedListener: (item, index, context) {
                          FocusScope.of(context).unfocus(); // dismiss keyboard
                          _userSettingsBox.put(_databaseFieldName, index);
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
