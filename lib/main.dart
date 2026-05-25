import 'package:flutter/material.dart';
import 'package:gym_workout_plan/screens/exercise_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GymWorkoutApp());
}

class GymWorkoutApp extends StatelessWidget {
  const GymWorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF06B6D4),
        onPrimary: Colors.black,
        primaryContainer: Color(0xFF083344),
        onPrimaryContainer: Color(0xFFCFFAFE),

        secondary: Color(0xFF6366F1),
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF1E1B4B),
        onSecondaryContainer: Color(0xFFE0E7FF),

        surface: Color(0xFF0F172A),
        onSurface: Color(0xFFF1F5F9),

        surfaceContainer: Color(0xFF1E293B),
        onSurfaceVariant: Color(0xFFCBD5E1),

        outline: Color(0xFF475569),
        outlineVariant: Color(0xFF334155),

        error: Color(0xFFEF4444),
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: const Color(0xFF0F172A),

      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.25),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        bodyMedium: TextStyle(letterSpacing: 0.25, height: 1.4),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
        prefixIconColor: const Color(0xFF06B6D4),
        suffixIconColor: const Color(0xFF06B6D4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF06B6D4), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF06B6D4),
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF06B6D4),
        foregroundColor: Colors.black,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF06B6D4),
      ),
    );

    return MaterialApp(
      title: 'Workout Tracker',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const ExerciseListScreen(),
    );
  }
}
