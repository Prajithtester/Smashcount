import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../data/database/database.dart';
import 'auth_provider.dart';

final playersDaoProvider = Provider<PlayersDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.playersDao;
});

final playersStreamProvider = StreamProvider<List<Player>>((ref) {
  final dao = ref.watch(playersDaoProvider);
  return dao.watchAllPlayers();
});

final playerNamesProvider = Provider<List<String>>((ref) {
  final players = ref.watch(playersStreamProvider).value ?? [];
  return players.map((p) => p.name).toList();
});

final statsDaoProvider = Provider<StatsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.statsDao;
});

final totalMatchesProvider = StreamProvider<int>((ref) {
  return ref.watch(statsDaoProvider).watchTotalMatches();
});

final totalPlayersProvider = StreamProvider<int>((ref) {
  return ref.watch(statsDaoProvider).watchTotalPlayers();
});

final leaderboardProvider = StreamProvider<List<PlayerWinCount>>((ref) {
  return ref.watch(statsDaoProvider).watchLeaderboard();
});

final extendedLeaderboardProvider = StreamProvider<List<PlayerWinCount>>((ref) {
  return ref.watch(statsDaoProvider).watchExtendedLeaderboard();
});

final matchTypeStatsProvider = StreamProvider<List<MatchTypeCount>>((ref) {
  return ref.watch(statsDaoProvider).watchMatchTypeStats();
});
