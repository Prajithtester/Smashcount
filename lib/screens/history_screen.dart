import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' hide Column; 
import '../../logic/auth_provider.dart';
import '../../data/database/database.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
        centerTitle: true,
      ),
      body: historyAsync.when(
        data: (matches) {
          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 64, color: colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    'No matches recorded yet.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final match = matches[index];
              return _buildHistoryCard(context, ref, match, colorScheme);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, WidgetRef ref, MatchData match, ColorScheme colorScheme) {
    final isSingles = match.matchType == 'Singles';
    final dateStr = DateFormat('MMM dd, yyyy • hh:mm a').format(match.date);

    return Dismissible(
      key: Key(match.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) async {
        final db = ref.read(databaseProvider);
        await (db.delete(db.matches)..where((t) => t.id.equals(match.id))).go();
        ref.invalidate(matchHistoryProvider);
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              match.matchType.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          Text(
                            dateStr,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTeamText(
                        match.playerA, 
                        match.playerC, 
                        match.winner == match.playerA || match.winner == ("${match.playerA} & ${match.playerC ?? ""}"),
                        colorScheme,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'VS', 
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.w900, 
                            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                          ),
                        ),
                      ),
                      _buildTeamText(
                        match.playerB, 
                        match.playerD, 
                        match.winner == match.playerB || match.winner == ("${match.playerB} & ${match.playerD ?? ""}"),
                        colorScheme,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamText(String p1, String? p2, bool isWinner, ColorScheme colorScheme) {
    final names = p2 != null ? '$p1 & $p2' : p1;
    return Row(
      children: [
        Expanded(
          child: Text(
            names,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              color: isWinner ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
        if (isWinner)
          Icon(Icons.check_circle, size: 16, color: colorScheme.primary),
      ],
    );
  }
}

