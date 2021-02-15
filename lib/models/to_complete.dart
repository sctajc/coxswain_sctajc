import 'package:hive/hive.dart';

part 'to_complete.g.dart';

@HiveType(typeId: 2)
enum ToComplete {
  @HiveField(0)
  Duration,
  @HiveField(1)
  Distance,
  @HiveField(2)
  TotalStrokes,
  @HiveField(3)
  Energy,
}

const ToCompleteString = <ToComplete, String>{
  ToComplete.Duration: "Duration",
  ToComplete.Distance: "Distance",
  ToComplete.TotalStrokes: "Total strokes",
  ToComplete.Energy: "Energy",
};
