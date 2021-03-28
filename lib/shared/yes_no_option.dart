import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:coxswain/shared/help_text_bottom_sheet.dart';

class YesNoOption extends StatelessWidget {
  const YesNoOption({
    // required Key key,
    required Box userSettingsBox,
    required String optionHeading,
    required int selectedInitialValue,
    required String databaseFieldName,
    required String helpLineOne,
    required String helpLineTwo,
    @required this.context,
  })  : userSettingsBox = userSettingsBox,
        optionHeading = optionHeading,
        selectedInitialValue = selectedInitialValue,
        databaseFieldName = databaseFieldName,
        helpLineOne = helpLineOne,
        helpLineTwo = helpLineTwo;
  // super(key: key);

  final Box userSettingsBox;
  final String optionHeading;
  final int selectedInitialValue;
  final String databaseFieldName;
  final String helpLineOne;
  final String helpLineTwo;
  final context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 75,
          child: Text(
            optionHeading,
            style: kFieldHeading,
          ),
        ),
        Center(
          child: ToggleSwitch(
              inactiveBgColor: Colors.grey[200],
              minWidth: 60,
              initialLabelIndex: selectedInitialValue,
              labels: ['Yes', 'No'],
              onToggle: (index) {
                FocusScope.of(context).unfocus(); // dismiss keyboard
                userSettingsBox.put(databaseFieldName, index);
              }),
        ),
        HelpTextBottomSheet(
          helpTextOne: helpLineOne,
          helpTextTwo: helpLineTwo,
        ),
      ],
    );
  }
}
