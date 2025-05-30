class CalculationUtils {
  // Calculate salad ratio based on number of selected salads
  static double calculateSaladRatio(int selectedSalads) {
    if (selectedSalads == 0) return 0.0;
    if (selectedSalads <= 3) return 1.0;
    return 3.0 / selectedSalads; // Max 300% total, distributed evenly
  }

  // Calculate sauce ratio based on number of selected sauces
  static double calculateSauceRatio(int selectedSauces) {
    if (selectedSauces == 0) return 0.0;
    if (selectedSauces == 1) return 1.0;
    if (selectedSauces == 2) return 0.5;
    if (selectedSauces >= 3) return 0.33; // Max 3 sauces
    return 1.0;
  }

  // Calculate weight factor
  static double calculateWeightFactor(
    double currentWeight,
    double standardWeight,
  ) {
    return currentWeight / standardWeight;
  }

  // Round to 1 decimal place
  static double roundToOneDecimal(double value) {
    return double.parse(value.toStringAsFixed(1));
  }

  // Helper methods for UI text
  static String getSaladSelectionText(int selectedSalads) {
    if (selectedSalads == 0) return 'No salads selected';
    if (selectedSalads <= 3) return '$selectedSalads salads (100% each)';

    final percentage = (300 / selectedSalads).round();
    return '$selectedSalads salads ($percentage% each)';
  }

  static String getSauceSelectionText(int selectedSauces) {
    if (selectedSauces == 0) return 'No sauces selected';
    if (selectedSauces == 1) return '1 sauce (100%)';
    if (selectedSauces == 2) return '2 sauces (50% each)';
    if (selectedSauces >= 3) return '3 sauces (33% each)';
    return '';
  }
}
