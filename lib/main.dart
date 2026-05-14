import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MeowCareApp());
}

class MeowCareApp extends StatelessWidget {
  const MeowCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeowCare',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),

        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFCBA6F7),
          secondary: const Color(0xFFCBA6F7),
        ),

        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          centerTitle: false,
        ),

        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
          contentTextStyle: GoogleFonts.poppins(),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFFCBA6F7), width: 2),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
