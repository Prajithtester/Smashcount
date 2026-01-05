import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../logic/auth_provider.dart';
import '../../logic/theme_provider.dart';
import '../../data/database/database.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  User? _currentUser;
  
  @override
  void initState() {
    super.initState();
    _loadUser();
  }
  
  Future<void> _loadUser() async {
    final db = ref.read(databaseProvider);
    final userId = ref.read(authProvider);
    if (userId != null) {
      final user = await (db.select(db.users)..where((u) => u.id.equals(userId))).getSingleOrNull();
      if (mounted) setState(() => _currentUser = user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Profile Section
          if (_currentUser != null) ...[
            UserAccountsDrawerHeader(
              accountName: Text(_currentUser!.username),
              accountEmail: Text(_currentUser!.email),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            ),
          ],
          
          const Divider(),
          
          // Appearance Section
          ListTile(
            leading: const Icon(Icons.brightness_4),
            title: const Text('Theme'),
            subtitle: Text(themeMode.toString().split('.').last.toUpperCase()),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newVal) {
                if (newVal != null) {
                  ref.read(themeProvider.notifier).setTheme(newVal);
                }
              },
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          
          const Divider(),
          
          // Account Section
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          ),
          
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Badminton Score Keeper v1.1.0',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
