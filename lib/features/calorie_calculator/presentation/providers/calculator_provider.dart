import 'package:flutter/foundation.dart';
import '../../data/models/kebab_component.dart';
import '../../data/repositories/kebab_repository.dart';
import '../../data/repositories/nutrition_repository.dart';
import '../../../../core/constants/app_constants.dart';

class CalculatorProvider extends ChangeNotifier {
  final KebabRepository _kebabRepository = KebabRepository();
  final NutritionRepository _nutritionRepository = NutritionRepository();

  String? _selectedBread;
  final List<String> _selectedMeats = [];
  final List<String> _selectedSalads = [];
  final List<String> _selectedSauces = [];
  double _kebabWeight = AppConstants.standardKebabWeight;

  String? get selectedBread => _selectedBread;
  List<String> get selectedMeats => List.unmodifiable(_selectedMeats);
  List<String> get selectedSalads => List.unmodifiable(_selectedSalads);
  List<String> get selectedSauces => List.unmodifiable(_selectedSauces);
  double get kebabWeight => _kebabWeight;

  List<KebabComponent> get breadOptions => _kebabRepository.getBreadOptions();
  List<KebabComponent> get meatOptions => _kebabRepository.getMeatOptions();
  List<KebabComponent> get saladOptions => _kebabRepository.getSaladOptions();
  List<KebabComponent> get sauceOptions => _kebabRepository.getSauceOptions();

  List<KebabComponent> get _allComponentsList => [
    ...breadOptions,
    ...meatOptions,
    ...saladOptions,
    ...sauceOptions,
  ];

  void selectBread(String? breadId) {
    _selectedBread = breadId;
    notifyListeners();
  }

  void toggleMeat(String meatId) {
    if (_selectedMeats.contains(meatId)) {
      _selectedMeats.remove(meatId);
    } else if (_selectedMeats.length < 2) {
      _selectedMeats.add(meatId);
    }
    notifyListeners();
  }

  void toggleSalad(String saladId) {
    if (_selectedSalads.contains(saladId)) {
      _selectedSalads.remove(saladId);
    } else if (_selectedSalads.length < 5) {
      _selectedSalads.add(saladId);
    }
    notifyListeners();
  }

  void toggleSauce(String sauceId) {
    if (_selectedSauces.contains(sauceId)) {
      _selectedSauces.remove(sauceId);
    } else if (_selectedSauces.length < AppConstants.maxSauces) {
      _selectedSauces.add(sauceId);
    }
    notifyListeners();
  }

  void updateWeight(double weight) {
    _kebabWeight = weight;
    notifyListeners();
  }

  bool get hasValidSelections =>
      _selectedBread != null &&
      _kebabRepository.isValidKebab(
        selectedMeats: _selectedMeats,
        selectedSalads: _selectedSalads,
        selectedSauces: _selectedSauces,
      );

  Map<ComponentType, Map<String, double>> get nutritionByType {
    return _nutritionRepository.calculateNutritionByType(
      selectedBread: _selectedBread,
      selectedMeats: _selectedMeats,
      selectedSalads: _selectedSalads,
      selectedSauces: _selectedSauces,
      kebabWeight: _kebabWeight,
      allComponents: _allComponentsList,
    );
  }

  Map<String, double> get totalNutrition {
    return _nutritionRepository.calculateTotalNutrition(
      nutritionByType: nutritionByType,
    );
  }

  bool get hasSelections =>
      _selectedBread != null ||
      _selectedMeats.isNotEmpty ||
      _selectedSalads.isNotEmpty ||
      _selectedSauces.isNotEmpty;

  void clearAllSelections() {
    _selectedBread = null;
    _selectedMeats.clear();
    _selectedSalads.clear();
    _selectedSauces.clear();
    _kebabWeight = AppConstants.standardKebabWeight;
    notifyListeners();
  }

  KebabComponent? getComponentById(String id) {
    return _kebabRepository.getComponentById(id);
  }

  String formatNutritionValue(double value, String nutrient) {
    return _nutritionRepository.formatNutritionValue(value, nutrient);
  }
}
