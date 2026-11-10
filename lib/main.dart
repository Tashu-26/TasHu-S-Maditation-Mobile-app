
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

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

      // Apply our custom app theme
      theme: AppTheme.lightTheme,

      // Temporary screen to test our theme
      home: const Scaffold(
        body: Center(
          child: Text(
            'Welcome to TasHu\'S Maditation!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
