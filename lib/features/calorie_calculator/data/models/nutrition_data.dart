class NutritionData {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;

  const NutritionData({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
  });

  NutritionData operator +(NutritionData other) {
    return NutritionData(
      calories: calories + other.calories,
      protein: protein + other.protein,
      carbohydrates: carbohydrates + other.carbohydrates,
      fat: fat + other.fat,
      fiber: fiber + other.fiber,
      sugar: sugar + other.sugar,
      sodium: sodium + other.sodium,
    );
  }

  NutritionData operator *(double multiplier) {
    return NutritionData(
      calories: calories * multiplier,
      protein: protein * multiplier,
      carbohydrates: carbohydrates * multiplier,
      fat: fat * multiplier,
      fiber: fiber * multiplier,
      sugar: sugar * multiplier,
      sodium: sodium * multiplier,
    );
  }

  static const NutritionData zero = NutritionData(
    calories: 0,
    protein: 0,
    carbohydrates: 0,
    fat: 0,
    fiber: 0,
    sugar: 0,
    sodium: 0,
  );
}
