import 'package:hive/hive.dart';

part 'intensity.g.dart';

@HiveType(typeId: 4)
enum Intensity {
  @HiveField(0)
  WarmUpBlue,
  @HiveField(1)
  EasyGreen,
  @HiveField(2)
  MediumYellow,
  @HiveField(3)
  HardOrange,
  @HiveField(4)
  CoolDownGrey,
  @HiveField(5)
  StretchingPurple,
  @HiveField(6)
  RestWhite,
}

const IntensityString = <Intensity, String>{
  Intensity.WarmUpBlue: "Warm up",
  Intensity.EasyGreen: "Easy",
  Intensity.MediumYellow: "Medium",
  Intensity.HardOrange: "Hard",
  Intensity.CoolDownGrey: "Cool down",
  Intensity.StretchingPurple: "Stretching",
  Intensity.RestWhite: "Rest",
};
