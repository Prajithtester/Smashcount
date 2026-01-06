import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../logic/match_state.dart';
import '../../logic/players_provider.dart';

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
  final _teamALabelController = TextEditingController(text: 'Team A');
  final _teamBLabelController = TextEditingController(text: 'Team B');

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _teamA1Controller.dispose();
    _teamA2Controller.dispose();
    _teamB1Controller.dispose();
    _teamB2Controller.dispose();
    _teamALabelController.dispose();
    _teamBLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerNames = ref.watch(playerNamesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Match'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Match Type Selection
              Center(
                child: SegmentedButton<MatchType>(
                  segments: const [
                    ButtonSegment(
                      value: MatchType.singles, 
                      label: Text('Singles'), 
                      icon: Icon(Icons.person_outline)
                    ),
                    ButtonSegment(
                      value: MatchType.doubles, 
                      label: Text('Doubles'), 
                      icon: Icon(Icons.group_outlined)
                    ),
                  ],
                  selected: {_selectedType},
                  onSelectionChanged: (Set<MatchType> newSelection) {
                    setState(() {
                      _selectedType = newSelection.first;
                    });
                  },
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                    backgroundColor: colorScheme.surface,
                    selectedBackgroundColor: colorScheme.primary,
                    selectedForegroundColor: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Team A Input
              _buildTeamSection('Team A', _teamALabelController, _teamA1Controller, _teamA2Controller, playerNames, colorScheme),
              const SizedBox(height: 24),
              
              Center(
                child: Text(
                  'VS', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18, 
                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Team B Input
              _buildTeamSection('Team B', _teamBLabelController, _teamB1Controller, _teamB2Controller, playerNames, colorScheme),
              
              const SizedBox(height: 48),
              
              ElevatedButton(
                onPressed: _startMatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('START BATTLE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    SizedBox(width: 8),
                    Icon(Icons.sports_score),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection(
    String defaultTitle,
    TextEditingController labelController, 
    TextEditingController c1, 
    TextEditingController c2, 
    List<String> playerNames,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: TextFormField(
            controller: labelController,
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 18, 
              color: colorScheme.primary,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: defaultTitle,
            ),
          ),
        ),
        _buildPlayerInput(
          controller: c1,
          label: _selectedType == MatchType.doubles ? 'Player 1' : 'Search or enter name...',
          options: playerNames,
        ),
        if (_selectedType == MatchType.doubles) ...[
          const SizedBox(height: 16),
          _buildPlayerInput(
            controller: c2,
            label: 'Player 2',
            options: playerNames,
          ),
        ],
      ],
    );
  }

  Widget _buildPlayerInput({
    required TextEditingController controller,
    required String label,
    required List<String> options,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<String>(
        textEditingController: controller,
        focusNode: FocusNode(),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return options.where((String option) {
            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          controller.text = selection;
        },
        fieldViewBuilder: (context, fieldTextEditingController, focusNode, onFieldSubmitted) {
          return TextFormField(
            controller: fieldTextEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.person_search_outlined),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
            ),
            validator: (v) => v?.isEmpty == true ? 'Required' : null,
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: constraints.maxWidth,
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      title: Text(option),
                      onTap: () => onSelected(option),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _startMatch() async {
    if (!_formKey.currentState!.validate()) return;

    final names = [
      _teamA1Controller.text,
      if (_selectedType == MatchType.doubles) _teamA2Controller.text,
      _teamB1Controller.text,
      if (_selectedType == MatchType.doubles) _teamB2Controller.text,
    ].where((n) => n.isNotEmpty).toList();

    // Save new players to DB
    await ref.read(playersDaoProvider).insertPlayers(names);

    ref.read(matchProvider.notifier).startMatch(
      type: _selectedType,
      pA1: _teamA1Controller.text,
      pA2: _selectedType == MatchType.doubles ? _teamA2Controller.text : null,
      pB1: _teamB1Controller.text,
      pB2: _selectedType == MatchType.doubles ? _teamB2Controller.text : null,
      teamALabel: _teamALabelController.text.isEmpty ? 'Team A' : _teamALabelController.text,
      teamBLabel: _teamBLabelController.text.isEmpty ? 'Team B' : _teamBLabelController.text,
    );

    context.go('/scoreboard');
  }
}

