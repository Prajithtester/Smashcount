import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift; 
import '../../logic/match_state.dart';
import '../../logic/auth_provider.dart';
import '../../data/database/database.dart';

class ScoreboardScreen extends ConsumerWidget {
  const ScoreboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref.watch(matchProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Listen for match completion
    ref.listen(matchProvider, (previous, next) {
      if (next.isContextFinished && (previous == null || !previous.isContextFinished)) {
        _showWinnerDialog(context, ref, next);
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(match.type == MatchType.singles ? 'Singles' : 'Doubles'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _confirmExit(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () => _showEditNamesDialog(context, ref, match),
          ),
        ],
      ),
      body: Column(
        children: [
          // Score Area
          Expanded(
            child: Row(
              children: [
                _buildScoreArea(
                  context, 
                  ref, 
                  team: match.teamA, 
                  isTeamA: true, 
                  match: match,
                  colorScheme: colorScheme,
                ),
                _buildScoreArea(
                  context, 
                  ref, 
                  team: match.teamB, 
                  isTeamA: false, 
                  match: match,
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
          
          // Match Status Overlay (Transition)
          if (match.matchStatus.isNotEmpty)
            _buildStatusBanner(context, match.matchStatus, colorScheme),

          // Bottom Info Bar
          _buildInfoPanel(context, match, colorScheme),
        ],
      ),
    );
  }

  Widget _buildScoreArea(
    BuildContext context, 
    WidgetRef ref, {
    required TeamState team, 
    required bool isTeamA, 
    required MatchSnapshot match,
    required ColorScheme colorScheme,
  }) {
    final isServing = isTeamA == match.isTeamAServing;
    final surfaceColor = isTeamA 
        ? (Theme.of(context).brightness == Brightness.dark ? colorScheme.surface.withBlue(60) : colorScheme.primary.withOpacity(0.05))
        : (Theme.of(context).brightness == Brightness.dark ? colorScheme.surface.withRed(60) : colorScheme.error.withOpacity(0.05));

    final accentColor = isTeamA ? colorScheme.primary : colorScheme.error;

    return Expanded(
      child: GestureDetector(
        onTap: () => ref.read(matchProvider.notifier).scorePointFor(isTeamA),
        child: Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            border: isServing ? Border.all(color: colorScheme.primary, width: 2) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isServing)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'SERVING',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                )
              else
                const SizedBox(height: 18),
              
              const SizedBox(height: 16),
              Text(
                team.name1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
              if (team.name2 != null)
                Text(
                  team.name2!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
              
              const SizedBox(height: 40),
              
              // Animated Score
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: team.score),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w900,
                      color: accentColor,
                      height: 1,
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 20),
              Icon(
                Icons.touch_app_outlined,
                size: 20,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, String status, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      color: colorScheme.secondary,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context, MatchSnapshot match, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildInfoItem(
            context, 
            label: 'SERVER', 
            value: match.currentServer,
            icon: Icons.subdirectory_arrow_right,
            colorScheme: colorScheme,
          ),
          const Spacer(),
          _buildInfoItem(
            context, 
            label: 'RECEIVER', 
            value: match.currentReceiver,
            icon: Icons.subdirectory_arrow_left,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String label, 
    required String value, 
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: colorScheme.primary.withOpacity(0.6)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quit Match?'),
        content: const Text('Current score will be lost.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('RESUME')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/');
            }, 
            child: const Text('QUIT', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showWinnerDialog(BuildContext context, WidgetRef ref, MatchSnapshot match) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Center(child: Text('Victory!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events_rounded, size: 80, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              match.winner ?? 'Draw',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Final Score: ${match.teamA.score} - ${match.teamB.score}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              final userId = ref.read(authProvider);
              
              if (userId != null) {
                final matchId = await db.into(db.matches).insert(MatchesCompanion(
                  creatorId: drift.Value(userId),
                  date: drift.Value(DateTime.now()),
                  matchType: drift.Value(match.type == MatchType.singles ? 'Singles' : 'Doubles'),
                  playerA: drift.Value(match.teamA.name1),
                  playerB: drift.Value(match.teamB.name1),
                  playerC: drift.Value(match.teamA.name2),
                  playerD: drift.Value(match.teamB.name2),
                  winner: drift.Value(match.winner),
                  teamALabel: drift.Value(match.teamA.teamLabel),
                  teamBLabel: drift.Value(match.teamB.teamLabel),
                  isCompleted: drift.Value(true),
                ));
                
                await db.into(db.matchSets).insert(MatchSetsCompanion(
                  matchId: drift.Value(matchId),
                  setNumber: drift.Value(1),
                  scoreA: drift.Value(match.teamA.score),
                  scoreB: drift.Value(match.teamB.score),
                ));
              }

              if (context.mounted) context.go('/');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('SAVE RESULTS'),
          ),
        ],
      ),
    );
  }

  void _showEditNamesDialog(BuildContext context, WidgetRef ref, MatchSnapshot match) {
    // Reuse existing logic but with better styling
    final aLabelController = TextEditingController(text: match.teamA.teamLabel);
    final a1Controller = TextEditingController(text: match.teamA.name1);
    final a2Controller = TextEditingController(text: match.teamA.name2 ?? '');
    
    final bLabelController = TextEditingController(text: match.teamB.teamLabel);
    final b1Controller = TextEditingController(text: match.teamB.name1);
    final b2Controller = TextEditingController(text: match.teamB.name2 ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Names'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: a1Controller, decoration: const InputDecoration(labelText: 'Team A - Player 1')),
              if (match.type == MatchType.doubles)
                 TextField(controller: a2Controller, decoration: const InputDecoration(labelText: 'Team A - Player 2')),
              
              const SizedBox(height: 24),
              
              TextField(controller: b1Controller, decoration: const InputDecoration(labelText: 'Team B - Player 1')),
              if (match.type == MatchType.doubles)
                 TextField(controller: b2Controller, decoration: const InputDecoration(labelText: 'Team B - Player 2')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(matchProvider.notifier).updateTeamNames(
                teamAP1: a1Controller.text,
                teamAP2: match.type == MatchType.doubles ? a2Controller.text : null,
                teamBP1: b1Controller.text,
                teamBP2: match.type == MatchType.doubles ? b2Controller.text : null,
                teamALabel: aLabelController.text,
                teamBLabel: bLabelController.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

