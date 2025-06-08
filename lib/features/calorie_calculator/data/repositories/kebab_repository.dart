// lib/features/calorie_calculator/data/repositories/kebab_repository.dart

import '../models/kebab_component.dart';
import '../models/nutrition_data.dart';

class KebabRepository {
  List<KebabComponent> getBreadOptions() {
    return NutritionData.breadOptions;
  }

  List<KebabComponent> getMeatOptions() {
    return NutritionData.meatOptions;
  }

  List<KebabComponent> getSaladOptions() {
    return NutritionData.saladOptions;
  }

  List<KebabComponent> getSauceOptions() {
    return NutritionData.sauceOptions;
  }

  KebabComponent? getComponentById(String id) {
    return NutritionData.getComponentById(id);
  }

  Map<ComponentType, List<KebabComponent>> getAllComponents() {
    return {
      ComponentType.bread: getBreadOptions(),
      ComponentType.meat: getMeatOptions(),
      ComponentType.salad: getSaladOptions(),
      ComponentType.sauce: getSauceOptions(),
    };
  }

  // Validation methods
  bool isValidKebab({
    required List<String> selectedMeats,
    required List<String> selectedSalads,
    required List<String> selectedSauces,
  }) {
    // Must have at least one meat
    if (selectedMeats.isEmpty) {
      return false;
    }

    // Can't have more than 2 meats
    if (selectedMeats.length > 2) {
      return false;
    }

    // Can't have more than 5 salads
    if (selectedSalads.length > 5) {
      return false;
    }

    // Can't have more than 3 sauces
    if (selectedSauces.length > 3) {
      return false;
    }

    return true;
  }

  String? getValidationError({
    required List<String> selectedMeats,
    required List<String> selectedSalads,
    required List<String> selectedSauces,
  }) {
    if (selectedMeats.isEmpty) {
      return 'Not a Kebab!\n(select a meat)';
    }

    if (selectedMeats.length > 2) {
      return 'Too many meats!\n(select up to 2)';
    }

    if (selectedSalads.length > 5) {
      return 'Too many salads!\n(select up to 5)';
    }

    if (selectedSauces.length > 3) {
      return 'Too many sauces!\n(select up to 3)';
    }

    return null;
  }
}
