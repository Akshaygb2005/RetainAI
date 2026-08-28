import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RetainAIApp());
}

class RetainAIApp extends StatelessWidget {
  const RetainAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RetainAI | Employee Churn Predictor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
