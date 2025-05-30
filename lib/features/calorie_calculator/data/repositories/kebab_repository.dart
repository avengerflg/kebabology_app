import '../models/kebab_component.dart';

class KebabRepository {
  static final List<KebabComponent> _allComponents = [
    // MEAT COMPONENTS
    const KebabComponent(
      name: 'Lamb/Beef Mince Doner',
      calories: 320.3,
      protein: 18.2,
      carbohydrates: 11.4,
      fat: 20.0, // Estimated from original lamb data
      fiber: 0.0,
      sugar: 0.0,
      sodium: 800.0, // Estimated for processed meat
      category: 'meat',
    ),
    const KebabComponent(
      name: 'Chicken Doner',
      calories: 221.1,
      protein: 28.3,
      carbohydrates: 3.3,
      fat: 5.6, // From original chicken data
      fiber: 0.0,
      sugar: 0.0,
      sodium: 650.0, // Estimated for processed chicken
      category: 'meat',
    ),
    const KebabComponent(
      name: 'Beef Lamb Steak Doner',
      calories: 303.5,
      protein: 29.5,
      carbohydrates: 0.9,
      fat: 1.7, // From original beef data
      fiber: 0.0,
      sugar: 0.0,
      sodium: 750.0, // Estimated for processed beef
      category: 'meat',
    ),

    // BREAD COMPONENTS
    const KebabComponent(
      name: 'Greek Pita Bread',
      calories: 253.3,
      protein: 8.2,
      carbohydrates: 49.8,
      fat: 2.5, // Estimated for bread
      fiber: 3.0,
      sugar: 2.0,
      sodium: 400.0,
      category: 'bread',
    ),
    const KebabComponent(
      name: 'Lebanese Bread',
      calories: 296.4,
      protein: 9.5,
      carbohydrates: 58.1,
      fat: 2.8, // Estimated for bread
      fiber: 3.5,
      sugar: 2.5,
      sodium: 450.0,
      category: 'bread',
    ),
    const KebabComponent(
      name: 'Turkish Bread',
      calories: 260.5,
      protein: 9.3,
      carbohydrates: 46.3,
      fat: 3.0, // Estimated for bread
      fiber: 2.8,
      sugar: 2.2,
      sodium: 420.0,
      category: 'bread',
    ),

    // SAUCE COMPONENTS
    const KebabComponent(
      name: 'Chilli Sauce',
      calories: 90.3,
      protein: 1.8,
      carbohydrates: 14.7,
      fat: 1.0, // Estimated
      fiber: 0.5,
      sugar: 12.0,
      sodium: 980.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'BBQ Sauce',
      calories: 210.3,
      protein: 0.5,
      carbohydrates: 50.5,
      fat: 0.2, // Estimated
      fiber: 0.3,
      sugar: 45.0,
      sodium: 1200.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Garlic Sauce',
      calories: 98.9,
      protein: 5.1,
      carbohydrates: 8.3,
      fat: 8.0, // Estimated for garlic sauce
      fiber: 0.2,
      sugar: 2.0,
      sodium: 650.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Hommus',
      calories: 251.0,
      protein: 7.9,
      carbohydrates: 9.3,
      fat: 18.0, // Estimated for hummus
      fiber: 6.0,
      sugar: 1.5,
      sodium: 450.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Tomato Sauce',
      calories: 112.3,
      protein: 1.4,
      carbohydrates: 25.0,
      fat: 0.3, // Estimated
      fiber: 1.2,
      sugar: 22.0,
      sodium: 1100.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Mayonnaise',
      calories: 698.9,
      protein: 1.9,
      carbohydrates: 1.5,
      fat: 75.0, // Estimated for mayo
      fiber: 0.0,
      sugar: 1.0,
      sodium: 580.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Sweet Chilli Sauce',
      calories: 249.8,
      protein: 0.2,
      carbohydrates: 60.8,
      fat: 0.5, // Estimated
      fiber: 0.8,
      sugar: 55.0,
      sodium: 890.0,
      category: 'sauce',
    ),
    const KebabComponent(
      name: 'Sour Cream',
      calories: 348.9,
      protein: 1.9,
      carbohydrates: 3.7,
      fat: 35.0, // Estimated for sour cream
      fiber: 0.0,
      sugar: 3.0,
      sodium: 320.0,
      category: 'sauce',
    ),

    // SALAD COMPONENTS
    const KebabComponent(
      name: 'Lettuce',
      calories: 19.6,
      protein: 1.4,
      carbohydrates: 1.8,
      fat: 0.1,
      fiber: 1.2,
      sugar: 1.0,
      sodium: 5.0,
      category: 'salad',
    ),
    const KebabComponent(
      name: 'Tomato',
      calories: 18.6,
      protein: 1.0,
      carbohydrates: 2.4,
      fat: 0.2,
      fiber: 1.0,
      sugar: 2.0,
      sodium: 8.0,
      category: 'salad',
    ),
    const KebabComponent(
      name: 'Fresh Onions',
      calories: 32.7,
      protein: 1.7,
      carbohydrates: 4.8,
      fat: 0.1,
      fiber: 1.5,
      sugar: 3.2,
      sodium: 3.0,
      category: 'salad',
    ),
    const KebabComponent(
      name: 'Parsley Tabouli',
      calories: 24.4,
      protein: 2.4,
      carbohydrates: 0.6,
      fat: 0.8,
      fiber: 3.0,
      sugar: 0.2,
      sodium: 15.0,
      category: 'salad',
    ),
    const KebabComponent(
      name: 'Cheese Tasty Cheddar',
      calories: 397.0,
      protein: 24.6,
      carbohydrates: 0.5,
      fat: 32.0, // Estimated for cheddar
      fiber: 0.0,
      sugar: 0.1,
      sodium: 650.0,
      category: 'salad',
    ),
  ];

  List<KebabComponent> getBreads() {
    return _allComponents
        .where((component) => component.category == 'bread')
        .toList();
  }

  List<KebabComponent> getMeats() {
    return _allComponents
        .where((component) => component.category == 'meat')
        .toList();
  }

  List<KebabComponent> getSalads() {
    return _allComponents
        .where((component) => component.category == 'salad')
        .toList();
  }

  List<KebabComponent> getSauces() {
    return _allComponents
        .where((component) => component.category == 'sauce')
        .toList();
  }

  List<KebabComponent> getAllComponents() {
    return List.unmodifiable(_allComponents);
  }

  KebabComponent? getComponentByName(String name) {
    try {
      return _allComponents.firstWhere((component) => component.name == name);
    } catch (e) {
      return null;
    }
  }

  List<KebabComponent> getComponentsByCategory(String category) {
    return _allComponents
        .where((component) => component.category == category)
        .toList();
  }
}
