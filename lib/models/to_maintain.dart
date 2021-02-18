import 'package:hive/hive.dart';

part 'to_maintain.g.dart';

@HiveType(typeId: 3)
enum ToMaintain {
  @HiveField(0)
  None,
  @HiveField(1)
  Speed,
  @HiveField(2)
  Pulse,
  @HiveField(3)
  StrokeRate,
  @HiveField(4)
  Power,
}

const ToMaintainString = <ToMaintain, String>{
  ToMaintain.None: "None",
  ToMaintain.Speed: "Speed/Pace",
  ToMaintain.Pulse: "Pulse",
  ToMaintain.StrokeRate: "Stroke Rate",
  ToMaintain.Power: "Power",
};
