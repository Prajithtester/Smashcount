import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../logic/match_state.dart';

class NewMatchScreen extends ConsumerStatefulWidget {
  const NewMatchScreen({super.key});

  @override
  ConsumerState<NewMatchScreen> createState() => _NewMatchScreenState();
}

class _NewMatchScreenState extends ConsumerState<NewMatchScreen> {
  MatchType _selectedType = MatchType.singles;
  
  // Controllers
  final _teamA1Controller = TextEditingController();
  final _teamA2Controller = TextEditingController();
  final _teamB1Controller = TextEditingController();
  final _teamB2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _teamA1Controller.dispose();
    _teamA2Controller.dispose();
    _teamB1Controller.dispose();
    _teamB2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start New Match')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Match Type Selection
              SegmentedButton<MatchType>(
                segments: const [
                  ButtonSegment(value: MatchType.singles, label: Text('Singles'), icon: Icon(Icons.person)),
                  ButtonSegment(value: MatchType.doubles, label: Text('Doubles'), icon: Icon(Icons.group)),
                ],
                selected: {_selectedType},
                onSelectionChanged: (Set<MatchType> newSelection) {
                  setState(() {
                    _selectedType = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 24),
              
              // Team A Input
              _buildTeamSection('Team A', _teamA1Controller, _teamA2Controller),
              const SizedBox(height: 24),
              
              // Team B Input
              _buildTeamSection('Team B', _teamB1Controller, _teamB2Controller),
              
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _startMatch,
                icon: const Icon(Icons.play_arrow),
                label: const Text('START MATCH'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection(String title, TextEditingController c1, TextEditingController c2) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: c1,
              decoration: InputDecoration(
                labelText: _selectedType == MatchType.doubles ? 'Player 1' : 'Player Name',
                border: const OutlineInputBorder(),
              ),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            if (_selectedType == MatchType.doubles) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: c2,
                decoration: const InputDecoration(
                  labelText: 'Player 2',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _startMatch() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(matchProvider.notifier).startMatch(
      type: _selectedType,
      pA1: _teamA1Controller.text,
      pA2: _selectedType == MatchType.doubles ? _teamA2Controller.text : null,
      pB1: _teamB1Controller.text,
      pB2: _selectedType == MatchType.doubles ? _teamB2Controller.text : null,
    );

    context.go('/scoreboard');
  }
}
