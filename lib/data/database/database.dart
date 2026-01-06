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
  TextColumn get teamALabel => text().withDefault(const Constant('Team A'))();
  TextColumn get teamBLabel => text().withDefault(const Constant('Team B'))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

class MatchSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get matchId => integer().references(Matches, #id, onDelete: KeyAction.cascade)();
  IntColumn get setNumber => integer()();
  IntColumn get scoreA => integer()();
  IntColumn get scoreB => integer()();
}

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftAccessor(tables: [Players])
class PlayersDao extends DatabaseAccessor<AppDatabase> with _$PlayersDaoMixin {
  PlayersDao(AppDatabase db) : super(db);

  Stream<List<Player>> watchAllPlayers() {
    return (select(players)..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();
  }

  Future<List<Player>> getAllPlayers() => select(players).get();

  Future<int> insertPlayer(String name) async {
    return into(players).insert(PlayersCompanion.insert(name: name), mode: InsertMode.insertOrIgnore);
  }
  
  Future<void> insertPlayers(List<String> names) async {
    await batch((batch) {
      batch.insertAll(players, names.map((name) => PlayersCompanion.insert(name: name)), mode: InsertMode.insertOrIgnore);
    });
  }

  Future<void> updatePlayer(Player player) => update(players).replace(player);
  
  Future<void> deletePlayer(Player player) => delete(players).delete(player);
}

class PlayerWinCount {
  final String name;
  final int wins;
  final int totalPlayed;
  double get winRate => totalPlayed > 0 ? (wins / totalPlayed) * 100 : 0;
  
  PlayerWinCount(this.name, this.wins, this.totalPlayed);
}

class MatchTypeCount {
  final String type;
  final int count;
  MatchTypeCount(this.type, this.count);
}

@DriftAccessor(tables: [Matches, MatchSets, Players])
class StatsDao extends DatabaseAccessor<AppDatabase> with _$StatsDaoMixin {
  StatsDao(AppDatabase db) : super(db);

  Future<int> getTotalMatches() async {
    final count = countAll();
    final query = selectOnly(matches)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingle();
    return result ?? 0;
  }

  Stream<int> watchTotalMatches() {
    final count = countAll();
    final query = selectOnly(matches)..addColumns([count]);
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Future<int> getTotalPlayers() async {
    final count = countAll();
    final query = selectOnly(players)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingle();
    return result ?? 0;
  }

  Stream<int> watchTotalPlayers() {
    final count = countAll();
    final query = selectOnly(players)..addColumns([count]);
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Future<List<PlayerWinCount>> getLeaderboard() {
    final winnerCount = matches.winner.count();
    final query = selectOnly(matches)
      ..addColumns([matches.winner, winnerCount])
      ..where(matches.winner.isNotNull())
      ..groupBy([matches.winner])
      ..orderBy([OrderingTerm(expression: winnerCount, mode: OrderingMode.desc)])
      ..limit(10);
    
    return query.map((row) {
      return PlayerWinCount(
        row.read(matches.winner) ?? 'Unknown',
        row.read(winnerCount) ?? 0,
        0, // Simplified for now
      );
    }).get();
  }

  Stream<List<PlayerWinCount>> watchLeaderboard() {
    final winnerCount = matches.winner.count();
    final query = selectOnly(matches)
      ..addColumns([matches.winner, winnerCount])
      ..where(matches.winner.isNotNull())
      ..groupBy([matches.winner])
      ..orderBy([OrderingTerm(expression: winnerCount, mode: OrderingMode.desc)])
      ..limit(10);
    
    return query.map((row) {
      return PlayerWinCount(
        row.read(matches.winner) ?? 'Unknown',
        row.read(winnerCount) ?? 0,
        0, // Simplified for now as we don't have total played in this query
      );
    }).watch();
  }

  Stream<List<PlayerWinCount>> watchExtendedLeaderboard() {
    return select(matches).watch().map((allMatches) {
      final completedMatches = allMatches.where((m) => m.isCompleted).toList();
      final Map<String, int> wins = {};
      final Map<String, int> played = {};

      void addMatch(String? name, bool isWin) {
        if (name == null || name.isEmpty) return;
        played[name] = (played[name] ?? 0) + 1;
        if (isWin) {
          wins[name] = (wins[name] ?? 0) + 1;
        }
      }

      for (final m in completedMatches) {
        final teamAWins = m.winner == m.teamALabel;
        final teamBWins = m.winner == m.teamBLabel;

        addMatch(m.playerA, teamAWins);
        addMatch(m.playerB, teamBWins);
        if (m.playerC != null && m.playerC!.isNotEmpty) addMatch(m.playerC, teamAWins);
        if (m.playerD != null && m.playerD!.isNotEmpty) addMatch(m.playerD, teamBWins);
      }

      final List<PlayerWinCount> leaderboard = played.keys.map((name) {
        return PlayerWinCount(name, wins[name] ?? 0, played[name] ?? 0);
      }).toList();

      leaderboard.sort((a, b) {
        final winCompare = b.wins.compareTo(a.wins);
        if (winCompare != 0) return winCompare;
        return b.totalPlayed.compareTo(a.totalPlayed);
      });

      return leaderboard.take(10).toList();
    });
  }

  Stream<List<MatchTypeCount>> watchMatchTypeStats() {
    return select(matches).watch().map((allMatches) {
      final Map<String, int> counts = {};
      for (final m in allMatches) {
        counts[m.matchType] = (counts[m.matchType] ?? 0) + 1;
      }
      return counts.entries.map((e) => MatchTypeCount(e.key, e.value)).toList();
    });
  }
}

@DriftDatabase(tables: [Users, Matches, MatchSets, Players], daos: [PlayersDao, StatsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(players);
        }
        if (from < 3) {
          await m.addColumn(matches, matches.teamALabel);
          await m.addColumn(matches, matches.teamBLabel);
        }
      },
    );
  }
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
