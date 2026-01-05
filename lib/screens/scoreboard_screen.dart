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

    // Listen for match completion
    ref.listen(matchProvider, (previous, next) {
      if (next.isContextFinished && !previous!.isContextFinished) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('Match Finished'),
            content: Text('Winner: ${next.winner}'),
            actions: [
              TextButton(
                onPressed: () async {
                   // Save Match
                   final db = ref.read(databaseProvider);
                   final userId = ref.read(authProvider);
                   
                   if (userId != null) {
                     final matchId = await db.into(db.matches).insert(MatchesCompanion(
                       creatorId: drift.Value(userId),
                       date: drift.Value(DateTime.now()),
                       matchType: drift.Value(next.type == MatchType.singles ? 'Singles' : 'Doubles'),
                       playerA: drift.Value(next.teamA.name1),
                       playerB: drift.Value(next.teamB.name1),
                       playerC: drift.Value(next.teamA.name2),
                       playerD: drift.Value(next.teamB.name2),
                       winner: drift.Value(next.winner),
                       isCompleted: drift.Value(true),
                     ));
                     
                     // Save final set score (simplified for now as just 1 "set" effectively)
                     await db.into(db.matchSets).insert(MatchSetsCompanion(
                       matchId: drift.Value(matchId),
                       setNumber: drift.Value(1),
                       scoreA: drift.Value(next.teamA.score),
                       scoreB: drift.Value(next.teamB.score),
                     ));
                   }
                  
                  if (context.mounted) context.go('/'); 
                },
                child: const Text('Save & Exit'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(match.type == MatchType.singles ? 'Singles Match' : 'Doubles Match'),
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Names',
            onPressed: () {
               _showEditNamesDialog(context, ref, match);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
               // Confirm exit
               showDialog(context: context, builder: (_) => AlertDialog(
                 title: const Text('End Match?'),
                 content: const Text('This will discard current progress.'),
                 actions: [
                   TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                   TextButton(onPressed: () => context.go('/'), child: const Text('End')),
                 ],
               ));
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Score Area
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Row(
                  children: [
                    _buildTeamArea(context, ref, match.teamA, true, match),
                    _buildTeamArea(context, ref, match.teamB, false, match),
                  ],
                ),
                // Status Overlay (Deuce / Advantage)
                if (match.matchStatus.isNotEmpty)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        match.matchStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Info Area
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('SERVER', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(match.currentServer, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                 Column(
                  children: [
                    const Text('RECEIVER', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(match.currentReceiver, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamArea(BuildContext context, WidgetRef ref, TeamState team, bool isTeamA, MatchSnapshot match) {
    final isServing = isTeamA == match.isTeamAServing;
    final color = isTeamA ? Colors.blue.shade50 : Colors.red.shade50;
    final textColor = isTeamA ? Colors.blue.shade900 : Colors.red.shade900;

    return Expanded(
      child: InkWell(
        onTap: () {
          ref.read(matchProvider.notifier).scorePointFor(isTeamA);
        },
        child: Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isServing) 
                const Icon(Icons.sports_tennis, size: 40, color: Colors.orange),
              
              Text(
                team.name1,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: textColor),
              ),
              if (team.name2 != null)
                Text(
                  team.name2!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: textColor),
                ),
              
              const SizedBox(height: 32),
              Text(
                '${team.score}',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900, 
                  fontSize: 120,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Tap to Add Point',
                style: TextStyle(color: textColor.withOpacity(0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showEditNamesDialog(BuildContext context, WidgetRef ref, MatchSnapshot match) {
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
              TextField(
                controller: aLabelController, 
                decoration: const InputDecoration(labelText: 'Team A Name', labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(controller: a1Controller, decoration: const InputDecoration(labelText: 'Player 1')),
              if (match.type == MatchType.doubles)
                 TextField(controller: a2Controller, decoration: const InputDecoration(labelText: 'Player 2')),
              
              const SizedBox(height: 24),
              
              TextField(
                controller: bLabelController, 
                decoration: const InputDecoration(labelText: 'Team B Name', labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(controller: b1Controller, decoration: const InputDecoration(labelText: 'Player 1')),
              if (match.type == MatchType.doubles)
                 TextField(controller: b2Controller, decoration: const InputDecoration(labelText: 'Player 2')),
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
