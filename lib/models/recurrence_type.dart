import 'package:hive/hive.dart';

part 'recurrence_type.g.dart';

@HiveType(typeId: 3)
enum RecurrenceType {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,  

  @HiveField(2)
  monthly,

  @HiveField(3)
  nonrecurring
}