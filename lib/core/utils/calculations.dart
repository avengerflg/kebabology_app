// lib/core/utils/calculations.dart

import '../constants/app_constants.dart';

class Calculations {
  // Calculate percentage of each component type
  static Map<String, double> calculateComponentPercentages(
    Map<String, double> componentCalories,
    double totalCalories,
  ) {
    if (totalCalories == 0) {
      return {'bread': 0, 'meat': 0, 'salad': 0, 'sauce': 0};
    }

    return {
      'bread': (componentCalories['bread'] ?? 0) / totalCalories * 100,
      'meat': (componentCalories['meat'] ?? 0) / totalCalories * 100,
      'salad': (componentCalories['salad'] ?? 0) / totalCalories * 100,
      'sauce': (componentCalories['sauce'] ?? 0) / totalCalories * 100,
    };
  }

  // Format weight display
  static String formatWeight(double weight) {
    return '${weight.round()}g';
  }

  // Format percentage display
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }

  // Calculate daily value percentage (based on 2000 calorie diet)
  static Map<String, double> calculateDailyValues(
    Map<String, double> nutrition,
  ) {
    const dailyValues = {
      'calories': 2000.0,
      'protein': 50.0,
      'carbohydrates': 300.0,
      'fat': 65.0,
      'saturatedFat': 20.0,
      'fiber': 25.0,
      'sugar': 50.0,
      'sodium': 2300.0,
    };

    final percentages = <String, double>{};

    nutrition.forEach((nutrient, value) {
      final dailyValue = dailyValues[nutrient];
      if (dailyValue != null && dailyValue > 0) {
        percentages[nutrient] = (value / dailyValue) * 100;
      }
    });

    return percentages;
  }

  // Get color based on daily value percentage
  static String getDailyValueColor(double percentage) {
    if (percentage <= 5) return 'low';
    if (percentage <= 20) return 'moderate';
    return 'high';
  }

  // Calculate weight difference from standard
  static String getWeightDifference(double weight) {
    final difference = weight - AppConstants.standardKebabWeight;
    if (difference == 0) return 'Standard weight';
    if (difference > 0) {
      return '+${difference.round()}g from standard';
    }
    return '${difference.round()}g from standard';
  }
}
