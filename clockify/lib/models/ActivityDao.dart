import 'package:clockify/models/ActivityModel.dart';
import 'package:floor/floor.dart';

@dao
abstract class ActivityDao {
  @Query('SELECT * FROM ActivityModel')
  Future<List<ActivityModel>> findAllActivity();

  @Query('SELECT * FROM ActivityModel WHERE description LIKE :desc')
  Future<List<ActivityModel>> findActivityByDescription(String desc);

  @insert
  Future<void> insertPerson(ActivityModel activity);

  @update
  Future<int> updateActivity(ActivityModel activity);

  @delete
  Future<int> deleteActivity(ActivityModel activity);

}