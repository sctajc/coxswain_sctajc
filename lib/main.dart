import 'package:coxswain/models/intensity.dart';
import 'package:coxswain/models/to_complete.dart';
import 'package:coxswain/models/to_maintain.dart';
import 'package:coxswain/shared/wrapper.dart';
import 'package:coxswain/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/program.dart';
import 'models/segment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(userSettingsBoxName);

  Hive.registerAdapter(ProgramAdapter());
  Hive.registerAdapter(SegmentAdapter());
  Hive.registerAdapter(ToCompleteAdapter());
  Hive.registerAdapter(ToMaintainAdapter());
  Hive.registerAdapter(IntensityAdapter());
  await Hive.openBox<Program>(programBoxName);
  await Hive.openBox<Segment>(segmentBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coxswain - Waterrower programs & workouts',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(context),
      home: Wrapper(),
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryTextTheme: GoogleFonts.solwayTextTheme(
        Theme.of(context).textTheme,
      ),
      primaryColor: kColorBlue,
      accentColor: kColorOrange,
      dividerColor: kColorOrange,
      textTheme: GoogleFonts.solwayTextTheme(Theme.of(context).textTheme),
      sliderTheme: SliderThemeData(
        thumbColor: kColorOrange,
        activeTrackColor: kColorOrange,
        inactiveTrackColor: Colors.orange[100],
      ),
      dividerTheme: DividerThemeData(
        color: kColorOrange,
        space: 50,
        thickness: 2,
        indent: 15,
        endIndent: 75,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: kColorOrange, // Background color (orange in my case).
        textTheme: ButtonTextTheme.accent,
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(secondary: Colors.white), // Text color
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        elevation: 10,
        backgroundColor: kColorOrange,
      ),
    );
  }
}
