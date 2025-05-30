import 'package:flutter/material.dart';

class AppConstants {
  // Tasty Doner Kebab Modern Theme Colors
  static const Color primaryColor = Color(0xFFF7F2E9);
  static const Color accentColor = Color(0xFFD32F2F);
  static const Color secondaryAccent = Color(0xFFFF5722);
  static const Color goldAccent = Color(0xFFFFB300);
  static const Color textColor = Color(0xFF2C2C2C);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color backgroundColor = Color(0xFFF7F2E9);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFEADDCA);
  static const Color surfaceColor = Color(0xFFFAF6F0);

  // Gradient Colors
  static const Color gradientStart = Color(0xFFD32F2F);
  static const Color gradientEnd = Color(0xFFFF5722);

  // App Strings
  static const String appName = 'TASTY DONER KEBAB';
  static const String makeKebabsGreatAgain =
      '🇦🇺 Make Kebabs Great Again 🇦🇺';
  static const String kebabCalorieCounter = 'Calorie Counter';
  static const String kebabalogue = 'Kebabalogue';

  // Calculation Constants based on your Excel data
  static const double maxSaladRatio = 3.0; // 300% max for salads
  static const int maxSauces = 3; // Maximum 3 sauces
  static const double standardKebabWeight = 430.0; // Base weight in grams

  // Standard ingredient weights for 430g kebab (from your data)
  static const Map<String, double> standardWeights = {
    'meat': 175.0, // Average meat component weight
    'bread': 92.7, // Average bread weight (98+80+100)/3
    'sauce': 26.6, // Average sauce weight per sauce
    'salad': 44.6, // Average salad weight per item
  };

  // Nutritional guidelines
  static const Map<String, String> nutritionUnits = {
    'calories': 'kcal',
    'protein': 'g',
    'carbohydrates': 'g',
    'fat': 'g',
    'fiber': 'g',
    'sugar': 'g',
    'sodium': 'mg',
  };
}
