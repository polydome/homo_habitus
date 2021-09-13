import 'dart:async';

import 'package:homo_habitus/data/database_schema.dart';
import 'package:homo_habitus/model/habit.dart';
import 'package:homo_habitus/repository/habit_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class HabitDao {
  HabitDao(this.db);

  static const String table = Tables.habit;
  final Database db;

  final Subject<void> _dataChangesController = BehaviorSubject.seeded(null);

  Stream<void> get _dataChanges => _dataChangesController.stream;

  Future<int> insert(Habit habit) async {
    final id = await db.insert(table, habit.toMap());
    _notifyDataChanged();
    return id;
  }

  Stream<List<Habit>> watch({String? where, List<Object?>? whereArgs}) =>
      _dataChanges.asyncMap((_) async =>
          (await db.query(table, where: where, whereArgs: whereArgs))
              .map((results) => habitFromMap(results))
              .toList());

  void _notifyDataChanged() {
    _dataChangesController.add(null);
  }
}
