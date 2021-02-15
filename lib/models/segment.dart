import 'package:coxswain/models/to_maintain.dart';
import 'package:hive/hive.dart';
import 'package:coxswain/models/intensity.dart';
import 'package:coxswain/models/to_complete.dart';

part 'segment.g.dart';

@HiveType(typeId: 1)
class Segment extends HiveObject {
  @HiveField(0)
  int segmentId;
  @HiveField(1)
  int programId;
  @HiveField(2)
  ToComplete toComplete;
  @HiveField(3)
  int valueToComplete;
  @HiveField(4)
  ToMaintain toMaintain;
  @HiveField(5)
  int valueToMaintain;
  @HiveField(6)
  Intensity intensity;

  Segment({
    this.segmentId = 0,
    this.programId = 0,
    this.toComplete = ToComplete.Duration,
    this.valueToComplete = 0,
    this.toMaintain = ToMaintain.None,
    this.valueToMaintain = 0,
    this.intensity = Intensity.EasyGreen,
  });
}
