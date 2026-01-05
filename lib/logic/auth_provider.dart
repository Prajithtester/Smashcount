import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart';
import '../data/database/database.dart';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); 
});

class AuthNotifier extends Notifier<int?> {
  late final AppDatabase db;
  
  @override
  int? build() {
    db = ref.read(databaseProvider);
    _loadUser();
    return null;
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    state = userId;
  }

  Future<bool> login(String username, String password) async {
    final user = await (db.select(db.users)..where((u) => u.username.equals(username) & u.passwordHash.equals(password))).getSingleOrNull();
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.id);
      state = user.id;
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final id = await db.into(db.users).insert(UsersCompanion(
        username: Value(username),
        email: Value(email),
        passwordHash: Value(password),
      ));
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', id);
      state = id;
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    state = null;
  }
}

// Fixed provider definition
final authProvider = NotifierProvider<AuthNotifier, int?>(AuthNotifier.new);

