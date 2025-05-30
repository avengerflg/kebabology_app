import 'package:flutter/foundation.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:kebabology_app/core/utils/calculations.dart';
import 'package:kebabology_app/features/calorie_calculator/data/models/kebab_component.dart';
import 'package:kebabology_app/features/calorie_calculator/data/models/nutrition_data.dart';
import 'package:kebabology_app/features/calorie_calculator/data/repositories/kebab_repository.dart';
import 'package:kebabology_app/features/calorie_calculator/data/repositories/nutrition_repository.dart';

class CalculatorProvider extends ChangeNotifier {
  final KebabRepository _kebabRepository = KebabRepository();
  final NutritionRepository _nutritionRepository = NutritionRepository();

  // Selected components
  KebabComponent? _selectedBread;
  KebabComponent? _selectedMeat;
  final List<KebabComponent> _selectedSalads = [];
  final List<KebabComponent> _selectedSauces = [];

  // Weight
  double _weight = AppConstants.standardKebabWeight;

  // Getters
  KebabComponent? get selectedBread => _selectedBread;
  KebabComponent? get selectedMeat => _selectedMeat;
  List<KebabComponent> get selectedSalads => List.unmodifiable(_selectedSalads);
  List<KebabComponent> get selectedSauces => List.unmodifiable(_selectedSauces);
  double get weight => _weight;

  // Repository getters
  List<KebabComponent> get breads => _kebabRepository.getBreads();
  List<KebabComponent> get meats => _kebabRepository.getMeats();
  List<KebabComponent> get salads => _kebabRepository.getSalads();
  List<KebabComponent> get sauces => _kebabRepository.getSauces();

  // Nutrition calculation
  NutritionData get totalNutrition {
    return _nutritionRepository.calculateTotalNutrition(
      selectedBread: _selectedBread,
      selectedMeat: _selectedMeat,
      selectedSalads: _selectedSalads,
      selectedSauces: _selectedSauces,
      weight: _weight,
    );
  }

  // Selection methods
  void selectBread(KebabComponent bread) {
    _selectedBread = bread;
    notifyListeners();
  }

  void selectMeat(KebabComponent meat) {
    _selectedMeat = meat;
    notifyListeners();
  }

  void toggleSalad(KebabComponent salad) {
    if (_selectedSalads.contains(salad)) {
      _selectedSalads.remove(salad);
    } else {
      _selectedSalads.add(salad);
    }
    notifyListeners();
  }

  void toggleSauce(KebabComponent sauce) {
    if (_selectedSauces.contains(sauce)) {
      _selectedSauces.remove(sauce);
    } else if (_selectedSauces.length < AppConstants.maxSauces) {
      _selectedSauces.add(sauce);
    }
    notifyListeners();
  }

  void updateWeight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void reset() {
    _selectedBread = null;
    _selectedMeat = null;
    _selectedSalads.clear();
    _selectedSauces.clear();
    _weight = AppConstants.standardKebabWeight;
    notifyListeners();
  }

  bool get canSelectMoreSauces =>
      _selectedSauces.length < AppConstants.maxSauces;

  // Helper methods for UI text
  String getSaladSelectionText() {
    return CalculationUtils.getSaladSelectionText(_selectedSalads.length);
  }

  String getSauceSelectionText() {
    return CalculationUtils.getSauceSelectionText(_selectedSauces.length);
  }
}
