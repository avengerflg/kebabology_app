import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:kebabology_app/core/utils/calculations.dart';
import 'package:kebabology_app/features/calorie_calculator/data/models/kebab_component.dart';
import 'package:kebabology_app/features/calorie_calculator/data/models/nutrition_data.dart';

class NutritionRepository {
  NutritionData calculateTotalNutrition({
    required KebabComponent? selectedBread,
    required KebabComponent? selectedMeat,
    required List<KebabComponent> selectedSalads,
    required List<KebabComponent> selectedSauces,
    required double weight,
  }) {
    NutritionData total = NutritionData.zero;

    final weightFactor = CalculationUtils.calculateWeightFactor(
      weight,
      AppConstants.standardKebabWeight,
    );

    // Add bread nutrition
    if (selectedBread != null) {
      total = total + _componentToNutrition(selectedBread) * weightFactor;
    }

    // Add meat nutrition
    if (selectedMeat != null) {
      total = total + _componentToNutrition(selectedMeat) * weightFactor;
    }

    // Add salad nutrition with ratio calculation
    if (selectedSalads.isNotEmpty) {
      final saladRatio = CalculationUtils.calculateSaladRatio(
        selectedSalads.length,
      );
      for (final salad in selectedSalads) {
        total =
            total + _componentToNutrition(salad) * weightFactor * saladRatio;
      }
    }

    // Add sauce nutrition with ratio calculation
    if (selectedSauces.isNotEmpty) {
      final sauceRatio = CalculationUtils.calculateSauceRatio(
        selectedSauces.length,
      );
      for (final sauce in selectedSauces) {
        total =
            total + _componentToNutrition(sauce) * weightFactor * sauceRatio;
      }
    }

    return total;
  }

  NutritionData _componentToNutrition(KebabComponent component) {
    return NutritionData(
      calories: component.calories,
      protein: component.protein,
      carbohydrates: component.carbohydrates,
      fat: component.fat,
      fiber: component.fiber,
      sugar: component.sugar,
      sodium: component.sodium,
    );
  }
}
