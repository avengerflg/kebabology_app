// lib/features/calorie_calculator/data/models/kebab_component.dart

class KebabComponent {
  final String id;
  final String name;
  final ComponentType type;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double saturatedFat;
  final double fiber;
  final double sugar;
  final double sodium;
  final double defaultGrams;

  const KebabComponent({
    required this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    this.fat = 0,
    this.saturatedFat = 0,
    this.fiber = 0,
    this.sugar = 0,
    this.sodium = 0,
    required this.defaultGrams,
  });
}

enum ComponentType { bread, meat, salad, sauce }

extension ComponentTypeExtension on ComponentType {
  String get displayName {
    switch (this) {
      case ComponentType.bread:
        return 'Bread';
      case ComponentType.meat:
        return 'Meat';
      case ComponentType.salad:
        return 'Salad';
      case ComponentType.sauce:
        return 'Sauce';
    }
  }
}
