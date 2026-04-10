import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0284C7),
  surface: const Color(0xFFF8FAFC),
  primary: const Color(0xFF0EA5E9),
  onSurface: const Color(0xFF0F172A),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env/.env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Weather', theme: theme, home: HomeScreen());
  }
}
