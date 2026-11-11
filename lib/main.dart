
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TasHuApp());
}

class TasHuApp extends StatelessWidget {
  const TasHuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TasHu\'S Maditation',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
