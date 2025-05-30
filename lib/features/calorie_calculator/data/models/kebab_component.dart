class KebabComponent {
  final String name;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;
  final String category;

  const KebabComponent({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.category,
  });

  KebabComponent copyWith({
    String? name,
    double? calories,
    double? protein,
    double? carbohydrates,
    double? fat,
    double? fiber,
    double? sugar,
    double? sodium,
    String? category,
  }) {
    return KebabComponent(
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KebabComponent &&
        other.name == name &&
        other.category == category;
  }

  @override
  int get hashCode => name.hashCode ^ category.hashCode;
}
