// lib/core/constants/app_constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'KEBABOLOGIST';
  static const String appDescription =
      'Track nutrition & make informed choices for your kebabs';

  // Tasty Doner Kebab Modern Theme Colors
  static const Color primaryColor = Color(0xFFF7F2E9);
  static const Color accentColor = Color(0xFFD32F2F);
  static const Color secondaryAccent = Color(0xFFFF5722);
  static const Color goldAccent = Color(0xFFFFB300);
  static const Color primaryDark = Color(0xFFB71C1C);

  // Background Colors
  static const Color backgroundColor = Color(0xFFF7F2E9);
  static const Color surfaceColor = Color(0xFFFAF6F0);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textColor = Color(0xFF2C2C2C);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color lightTextColor = Color(0xFF999999);

  // Border & Divider Colors
  static const Color borderColor = Color(0xFFEADDCA);
  static const Color dividerColor = Color(0xFFE0D5C7);

  // Gradient Colors
  static const Color gradientStart = Color(0xFFD32F2F);
  static const Color gradientEnd = Color(0xFFFF5722);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFFB300);
  static const Color infoColor = Color(0xFF2196F3);

  // App Strings
  static const String makeKebabsGreatAgain =
      '🇦🇺 Make Kebabs Great Again 🇦🇺';
  static const String kebabCalorieCounter = 'Calorie Counter';
  static const String kebabalogue = 'Kebabalogue';

  // EXACT Excel Constants
  static const double standardKebabWeight = 430.0; // Base weight from Excel
  static const int maxSauces = 3; // Maximum 3 sauces from Excel
  static const int maxMeats = 2;
  static const int maxSalads = 5;

  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;
  static const double paddingXXXL = 32.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusXXXL = 28.0;

  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeXXXL = 24.0;
  static const double fontSizeHeading = 28.0;
  static const double fontSizeDisplay = 36.0;

  // Nutritional guidelines
  static const Map<String, String> nutritionUnits = {
    'calories': 'kcal',
    'protein': 'g',
    'carbohydrates': 'g',
    'fat': 'g',
    'saturatedFat': 'g',
    'fiber': 'g',
    'sugar': 'g',
    'sodium': 'mg',
  };

  // Shadows
  static List<BoxShadow> get lightShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.8),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get heavyShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 30,
      offset: const Offset(0, 15),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.1),
      blurRadius: 5,
      offset: const Offset(0, -1),
    ),
  ];

  static List<BoxShadow> accentShadow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.3),
      blurRadius: 25,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.1),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  // Gradients
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [accentColor, secondaryAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get cardGradient => const LinearGradient(
    colors: [cardColor, surfaceColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get backgroundGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColor, surfaceColor, cardColor],
    stops: [0.0, 0.4, 1.0],
  );

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 400);
  static const Duration animationSlow = Duration(milliseconds: 600);
  static const Duration animationExtraSlow = Duration(milliseconds: 800);
}
