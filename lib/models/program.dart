import 'package:hive/hive.dart';

part 'program.g.dart';

@HiveType(typeId: 0)
class Program extends HiveObject {
  @HiveField(0)
  int programId;
  @HiveField(1)
  String programName;

  Program({this.programId = 0, this.programName = ''});
}
