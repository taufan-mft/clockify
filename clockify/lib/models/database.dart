import 'dart:async';
import 'package:clockify/models/ActivityDao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ActivityModel.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ActivityModel])
abstract class AppDatabase extends FloorDatabase {
  ActivityDao get activityDao;
}