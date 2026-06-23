import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job Hunter Command Center',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // Default to elite Dark mode JCC theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF0A0A0E),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.purpleAccent,
          surface: Color(0xFF0A0A0E),
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.purple,
          surface: Color(0xFFF3F4F6),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
