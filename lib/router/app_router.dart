import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../logic/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/new_match_screen.dart';
import '../screens/scoreboard_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/players_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final isAuthRoute = state.matchedLocation == '/login' || 
                          state.matchedLocation == '/register' ||
                          state.matchedLocation == '/splash';

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && state.matchedLocation == '/login') return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(), 
      ),
      GoRoute(
        path: '/new-match',
        builder: (context, state) => const NewMatchScreen(),
      ),
      GoRoute(
        path: '/scoreboard',
        builder: (context, state) => const ScoreboardScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/players',
        builder: (context, state) => const PlayersScreen(),
      ),
      GoRoute(
        path: '/stats',
        builder: (context, state) => const StatsScreen(),
      ),
    ],
  );
});
