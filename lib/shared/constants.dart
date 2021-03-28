import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kTextInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorOrange, width: 2),
  ),
  fillColor: Colors.white,
  filled: true,
);

const kColorOrange = Color(0xfffda400);
const kColorOrangeBold = Color(0xffbe7000);
const kColorBlue = Color(0xff1691e6);
const kColorCardChildren = Color(0xffF0F0F0);
const kHeading = TextStyle(fontWeight: FontWeight.bold, color: kColorOrange);
const kFieldHeading = TextStyle(fontWeight: FontWeight.normal, color: kColorOrange);
const kInputText = TextStyle(fontWeight: FontWeight.normal, color: Colors.black);

// hive Box names
const userSettingsBoxName = 'user_settings';
const programBoxName = 'programs';
const segmentBoxName = 'segments';

// database field names
String kFieldUserName = 'user_name';
String kFieldUserWeight = 'user_weight';
String kFieldWeight = 'weight_type'; // 0 = Kg, 1 = pounds
String kFieldAdjustEnergyToBodyWeight = 'adjust_to_body_weight'; // 0 = yes, 1 =no
String kFieldDistance = 'distance_type';
String kFieldSpeed = 'speed_type';
String kFieldEnergy = 'energy_type';
String kFieldProgramLevel = 'program_level';
String kFieldKeepRowing = 'keep_rowing'; // 0 = yes, 1 = no
String kFieldAdjustSpeed = 'adjust_speed'; // 0 = yes, 1 = no
String kFieldLinkToFit = 'link_to_fit'; // 0 = yes, 1 = no
String kFieldLinkToStrada = 'link_to_strada'; // 0 = yes, 1 = no
String kFieldExportWorkout = 'export_workout'; // 0 = yes, 1 = no
String kFieldStartURL = 'start_url'; // 0 = yes, 1 = no
String kFieldStartActualURL = 'actual_start_url'; // 0 = yes, 1 = no
String kFieldSegmentInstruction = 'segment_instruction'; // 0 = yes, 1 = no
String kFieldSegmentSound = 'segment_sound'; // 0 = yes, 1 = no
String kFieldWriteLog = 'write_log'; // 0 = yes, 1 = no
String kFieldWriteTrace = 'write_trace'; // 0 = yes, 1 = no

// settings range of options for the user's weight
var optionsUsersWeight =
    List<String>.generate(280, (index) => (49 + (index + 1)).toString(), growable: false);

// settings range of options
// note: make the first item the default by convention (0)
// always add any additions after the last one
List<String> optionsDistance = [
  "meters",
  "feet",
  "yards",
  "miles",
];

List<String> optionsEnergy = [
  "Kcal",
  "watt-hour",
  "kJ",
];

List<String> optionsSpeedPace = [
  "minutes/500 meters",
  "avg minutes/500 meters",
  "m/s",
  "kph",
  "mph",
  "minutes/2km",
  "kcal/hour",
];

List<String> optionsProgramLevel = ["Beginners", "Keep fit", "Cardio", "Strength", "HIIT"];
