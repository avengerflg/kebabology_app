import 'package:flutter/material.dart';
import 'package:kebabologist_app/core/theme/app_theme.dart';
import 'package:kebabologist_app/features/calorie_calculator/presentation/providers/calculator_provider.dart';
import 'package:kebabologist_app/features/home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CalculatorProvider())],
      child: MaterialApp(
        title: 'Tasty Doner Kebab Calculator',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
