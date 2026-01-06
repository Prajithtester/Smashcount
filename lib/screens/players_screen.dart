import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/players_provider.dart';
import '../data/database/database.dart';

class PlayersScreen extends ConsumerStatefulWidget {
  const PlayersScreen({super.key});

  @override
  ConsumerState<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends ConsumerState<PlayersScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playersAsync = ref.watch(playersStreamProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Players'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search players...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
            ),
          ),
          Expanded(
            child: playersAsync.when(
              data: (players) {
                final filteredPlayers = players.where((p) => p.name.toLowerCase().contains(_searchQuery)).toList();
                
                if (filteredPlayers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: colorScheme.outline),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty ? 'No players saved yet.' : 'No players matching "$_searchQuery"',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: filteredPlayers.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final player = filteredPlayers[index];
                    return _buildPlayerCard(context, ref, player, colorScheme);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: colorScheme.error))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, WidgetRef ref, Player player, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            player.name.substring(0, 1).toUpperCase(),
            style: TextStyle(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          player.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface),
        ),
        subtitle: Text(
          'Added on ${player.createdAt.toString().split(' ')[0]}',
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, color: colorScheme.primary),
              onPressed: () => _showEditDialog(context, ref, player),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: colorScheme.error),
              onPressed: () => _confirmDelete(context, ref, player, colorScheme),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Player player) {
    final controller = TextEditingController(text: player.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Player'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Player Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await ref.read(playersDaoProvider).updatePlayer(
                  player.copyWith(name: controller.text),
                );
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Player player, ColorScheme colorScheme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Player?'),
        content: Text('Are you sure you want to remove ${player.name}? This will not affect past matches.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await ref.read(playersDaoProvider).deletePlayer(player);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text('Delete', style: TextStyle(color: colorScheme.error)),
          ),
        ],
      ),
    );
  }
}
