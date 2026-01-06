import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'router/app_router.dart';
import 'logic/theme_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SmashCount',
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          primary: const Color(0xFF0F172A),
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFF1F5F9),
          onPrimaryContainer: const Color(0xFF0F172A),
          secondary: const Color(0xFF334155),
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: const Color(0xFF0F172A),
          surfaceVariant: const Color(0xFFF1F5F9),
          onSurfaceVariant: const Color(0xFF64748B),
          outline: const Color(0xFFE2E8F0),
          outlineVariant: const Color(0xFFF1F5F9),
          errorContainer: const Color(0xFFFEE2E2),
          onErrorContainer: const Color(0xFFB91C1C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020617),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8), // Bright Blue
          onPrimary: Color(0xFF020617),
          primaryContainer: Color(0xFF0F172A),
          onPrimaryContainer: Color(0xFF38BDF8),
          secondary: Color(0xFF1E293B),
          onSecondary: Colors.white,
          surface: Color(0xFF0F172A),
          onSurface: Color(0xFFF8FAFC),
          surfaceVariant: Color(0xFF1E293B),
          onSurfaceVariant: Color(0xFF94A3B8),
          outline: Color(0xFF334155),
          outlineVariant: Color(0xFF1E293B),
          error: Color(0xFFFB7185),
          errorContainer: Color(0xFF450A0A),
          onErrorContainer: Color(0xFFFB7185),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: const Color(0xFFF8FAFC),
          displayColor: const Color(0xFFF8FAFC),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: const Color(0xFF0F172A),
        ),
      ),
      routerConfig: router,
    );
  }
}
