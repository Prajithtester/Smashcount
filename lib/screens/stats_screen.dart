import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/players_provider.dart';
import '../data/database/database.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalMatchesAsync = ref.watch(totalMatchesProvider);
    final totalPlayersAsync = ref.watch(totalPlayersProvider);
    final leaderboardAsync = ref.watch(extendedLeaderboardProvider);
    final matchTypeStatsAsync = ref.watch(matchTypeStatsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSummarySection(totalMatchesAsync, totalPlayersAsync, colorScheme),
                const SizedBox(height: 32),
                _buildMatchTypeSection(matchTypeStatsAsync, colorScheme, context),
                const SizedBox(height: 32),
                Text(
                  'Top Performance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLeaderboard(leaderboardAsync, colorScheme),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(
    AsyncValue<int> matches, 
    AsyncValue<int> players, 
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatTile(
            'Total Matches', 
            matches.maybeWhen(data: (d) => '$d', orElse: () => '...'),
            Icons.sports_tennis_rounded,
            colorScheme.primary,
            colorScheme,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatTile(
            'Total Players', 
            players.maybeWhen(data: (d) => '$d', orElse: () => '...'),
            Icons.people_alt_rounded,
            colorScheme.secondary,
            colorScheme,
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon, Color color, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTypeSection(AsyncValue<List<MatchTypeCount>> matchTypeStats, ColorScheme colorScheme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Match Distribution',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: matchTypeStats.when(
            data: (stats) {
              if (stats.isEmpty) return const Center(child: Text('No data'));
              
              final total = stats.fold(0, (sum, e) => sum + e.count);
              final singles = stats.firstWhere((e) => e.type == 'Singles', orElse: () => MatchTypeCount('Singles', 0)).count;
              final doubles = stats.firstWhere((e) => e.type == 'Doubles', orElse: () => MatchTypeCount('Doubles', 0)).count;
              
              final singlesPercent = total > 0 ? singles / total : 0.0;
              final doublesPercent = total > 0 ? doubles / total : 0.0;

              return Column(
                children: [
                  Row(
                    children: [
                      _buildDistributionLabel('Singles', '$singles', colorScheme.primary),
                      const Spacer(),
                      _buildDistributionLabel('Doubles', '$doubles', colorScheme.secondary),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 12,
                      child: Row(
                        children: [
                          if (singlesPercent > 0)
                            Expanded(
                              flex: (singlesPercent * 100).toInt(),
                              child: Container(color: colorScheme.primary),
                            ),
                          if (doublesPercent > 0)
                            Expanded(
                              flex: (doublesPercent * 100).toInt(),
                              child: Container(color: colorScheme.secondary),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading stats'),
          ),
        ),
      ],
    );
  }

  Widget _buildDistributionLabel(String label, String value, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(width: 4),
        Text('($value)', style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLeaderboard(AsyncValue<List<PlayerWinCount>> leaderboard, ColorScheme colorScheme) {
    return leaderboard.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text(
              'No match data yet.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: colorScheme.outlineVariant),
            itemBuilder: (context, index) {
              final player = results[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: index == 0 ? Colors.amber : (index == 1 ? Colors.grey.shade400 : (index == 2 ? Colors.brown.shade300 : colorScheme.surfaceContainerHighest)),
                  foregroundColor: index <= 2 ? Colors.black87 : colorScheme.onSurface,
                  child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
                title: Text(
                  player.name, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                ),
                subtitle: Text(
                  'Played: ${player.totalPlayed} • Win Rate: ${player.winRate.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${player.wins} Wins',
                    style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: colorScheme.error))),
    );
  }
}
