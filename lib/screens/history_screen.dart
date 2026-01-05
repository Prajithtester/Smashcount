import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' hide Column; // Import drift for OrderingTerm/Mode
import '../../logic/auth_provider.dart';
import '../../data/database/database.dart';

// Match History Provider
final matchHistoryProvider = FutureProvider.autoDispose<List<MatchData>>((ref) async {
  final db = ref.read(databaseProvider);
  final userId = ref.watch(authProvider);
  
  if (userId == null) return [];

  return (db.select(db.matches)
    ..where((t) => t.creatorId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
    .get();
});

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(matchHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Match History')),
      body: historyAsync.when(
        data: (matches) {
          if (matches.isEmpty) {
            return const Center(child: Text('No matches recorded yet.'));
          }
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.sports_tennis),
                  title: Text(
                    match.matchType == 'Singles' 
                      ? '${match.playerA} vs ${match.playerB}'
                      : '${match.playerA}/${match.playerC} vs ${match.playerB}/${match.playerD}'
                  ),
                  subtitle: Text(DateFormat.yMMMd().add_jm().format(match.date)),
                  trailing: Text(
                    match.winner != null ? 'Winner: ${match.winner}' : 'Incomplete',
                    style: TextStyle(
                      color: match.winner != null ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
