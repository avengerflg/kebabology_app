import '../models/kebab_component.dart';
import '../../../../core/constants/app_constants.dart';

class NutritionRepository {
  // --- NEW: Pre-defined gram portions for mixed meats, as per Excel logic ---
  static const double _mixedPortionLamb = 87.5;
  static const double _mixedPortionChicken = 85.0;
  static const double _mixedPortionBeef = 93.5;

  // Base weight for scaling calculations
  static const double _baseWeight = 430.0;

  Map<String, double> initializeNutritionMap() {
    return {
      'calories': 0,
      'protein': 0,
      'carbohydrates': 0,
      'fat': 0,
      'saturatedFat': 0,
      'fiber': 0,
      'sugar': 0,
      'sodium': 0,
    };
  }

  void _addNutrition(
    Map<String, double> total,
    KebabComponent component,
    double grams,
  ) {
    if (grams <= 0) return;
    total['calories'] = total['calories']! + (component.calories / 100) * grams;
    total['protein'] = total['protein']! + (component.protein / 100) * grams;
    total['carbohydrates'] =
        total['carbohydrates']! + (component.carbohydrates / 100) * grams;
    total['fat'] = total['fat']! + (component.fat / 100) * grams;
    total['saturatedFat'] =
        total['saturatedFat']! + (component.saturatedFat / 100) * grams;
    total['sugar'] = total['sugar']! + (component.sugar / 100) * grams;
    total['sodium'] = total['sodium']! + (component.sodium / 100) * grams;
  }

  Map<ComponentType, Map<String, double>> calculateNutritionByType({
    required String? selectedBread,
    required List<String> selectedMeats,
    required List<String> selectedSalads,
    required List<String> selectedSauces,
    required double kebabWeight,
    required List<KebabComponent> allComponents,
  }) {
    final Map<ComponentType, Map<String, double>> finalNutrition = {
      ComponentType.bread: initializeNutritionMap(),
      ComponentType.meat: initializeNutritionMap(),
      ComponentType.salad: initializeNutritionMap(),
      ComponentType.sauce: initializeNutritionMap(),
    };

    if (selectedBread == null || selectedMeats.isEmpty) {
      return finalNutrition;
    }

    get(String id) => allComponents.firstWhere((comp) => comp.id == id);

    // Calculate weight factor for scaling
    final double weightFactor = kebabWeight / _baseWeight;

    // 1. Bread (Direct Sum - no scaling as per Excel)
    final breadComp = get(selectedBread);
    _addNutrition(
      finalNutrition[ComponentType.bread]!,
      breadComp,
      breadComp.defaultGrams,
    );

    // 2. Meat (Handles single and the specific mixed logic with weight scaling)
    if (selectedMeats.length == 1) {
      // Single meat: use its own default grams scaled by weight factor
      final meatComp = get(selectedMeats.first);
      _addNutrition(
        finalNutrition[ComponentType.meat]!,
        meatComp,
        meatComp.defaultGrams * weightFactor,
      );
    } else if (selectedMeats.length == 2) {
      // Mixed meats: use the pre-defined fixed portions scaled by weight factor
      for (var meatId in selectedMeats) {
        double portion = 0;
        if (meatId == 'lamb') {
          portion = _mixedPortionLamb;
        } else if (meatId == 'chicken') {
          portion = _mixedPortionChicken;
        } else if (meatId == 'beef') {
          portion = _mixedPortionBeef;
        }
        _addNutrition(
          finalNutrition[ComponentType.meat]!,
          get(meatId),
          portion * weightFactor,
        );
      }
    }

    // 3. Salads (Direct Sum with weight scaling)
    for (var saladId in selectedSalads) {
      final saladComp = get(saladId);
      _addNutrition(
        finalNutrition[ComponentType.salad]!,
        saladComp,
        saladComp.defaultGrams * weightFactor,
      );
    }

    // 4. Sauces (Direct Sum or Shared Portion with weight scaling)
    if (selectedSauces.length == 1) {
      final sauceComp = get(selectedSauces.first);
      _addNutrition(
        finalNutrition[ComponentType.sauce]!,
        sauceComp,
        sauceComp.defaultGrams * weightFactor,
      );
    } else if (selectedSauces.isNotEmpty) {
      const double standardSaucePortion = 28.0;
      double sauceGramsPerSelection =
          (standardSaucePortion / selectedSauces.length) * weightFactor;
      for (var sauceId in selectedSauces) {
        _addNutrition(
          finalNutrition[ComponentType.sauce]!,
          get(sauceId),
          sauceGramsPerSelection,
        );
      }
    }

    return finalNutrition;
  }

  Map<String, double> calculateTotalNutrition({
    required Map<ComponentType, Map<String, double>> nutritionByType,
  }) {
    final totalNutrition = initializeNutritionMap();
    for (var typeNutrition in nutritionByType.values) {
      typeNutrition.forEach((key, value) {
        totalNutrition[key] = totalNutrition[key]! + value;
      });
    }
    return totalNutrition;
  }

  String formatNutritionValue(double value, String nutrient) {
    final unit = AppConstants.nutritionUnits[nutrient] ?? '';
    return '${value.toStringAsFixed(1)}$unit';
  }
}
