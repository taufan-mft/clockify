import 'package:floor/floor.dart';

@entity
class ActivityModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int seconds;
  final int minutes;
  final int hours;
  final String startTime;
  final String endTime;
  late String description;
  final String location;
  final String date;

  ActivityModel(
      {this.id,
      required this.seconds,
      required this.minutes,
      required this.hours,
      required this.startTime,
      required this.endTime,
      required this.description,
      required this.location,
      required this.date});
}
