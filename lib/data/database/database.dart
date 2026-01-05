import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 1, max: 50).unique()();
  TextColumn get email => text().withLength(min: 1, max: 100).unique()();
  TextColumn get passwordHash => text()(); 
}

@DataClassName('MatchData')
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get creatorId => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get matchType => text()(); // "Singles" or "Doubles"
  TextColumn get playerA => text()();
  TextColumn get playerB => text()();
  TextColumn get playerC => text().nullable()(); // For doubles
  TextColumn get playerD => text().nullable()(); // For doubles
  TextColumn get winner => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

class MatchSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get matchId => integer().references(Matches, #id, onDelete: KeyAction.cascade)();
  IntColumn get setNumber => integer()();
  IntColumn get scoreA => integer()();
  IntColumn get scoreB => integer()();
}

@DriftDatabase(tables: [Users, Matches, MatchSets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
