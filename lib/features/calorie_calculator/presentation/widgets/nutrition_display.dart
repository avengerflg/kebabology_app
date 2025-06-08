// lib/features/calorie_calculator/presentation/widgets/nutrition_display.dart

import 'package:flutter/material.dart';
import '../../data/models/kebab_component.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/calculations.dart';

class NutritionDisplay extends StatelessWidget {
  final Map<String, double> totalNutrition;
  final Map<ComponentType, Map<String, double>> nutritionByType;
  final bool isValid;
  final String? errorMessage;

  const NutritionDisplay({
    super.key,
    required this.totalNutrition,
    required this.nutritionByType,
    required this.isValid,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!isValid && errorMessage != null) {
      return _buildErrorDisplay(context, theme);
    }

    final calories = totalNutrition['calories'] ?? 0;
    final protein = totalNutrition['protein'] ?? 0;
    final carbs = totalNutrition['carbohydrates'] ?? 0;

    return Column(
      children: [
        _buildMainNutritionCard(context, theme, calories, protein, carbs),
        const SizedBox(height: 16),
        _buildDetailedNutritionCard(context, theme),
      ],
    );
  }

  Widget _buildErrorDisplay(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppConstants.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppConstants.accentColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: AppConstants.accentColor,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppConstants.accentColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMainNutritionCard(
    BuildContext context,
    ThemeData theme,
    double calories,
    double protein,
    double carbs,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppConstants.accentColor, AppConstants.secondaryAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.accentColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.1), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNutritionItem(
              theme,
              'Calories',
              calories.round().toString(),
              'kcal',
              Icons.local_fire_department,
              Colors.orange,
            ),
            _buildNutritionItem(
              theme,
              'Protein',
              protein.round().toString(),
              'g',
              Icons.fitness_center,
              Colors.blue,
            ),
            _buildNutritionItem(
              theme,
              'Carbs',
              carbs.round().toString(),
              'g',
              Icons.grain,
              Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(
    ThemeData theme,
    String label,
    String value,
    String unit,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedNutritionCard(BuildContext context, ThemeData theme) {
    final calories = totalNutrition['calories'] ?? 0;
    final protein = totalNutrition['protein'] ?? 0;
    final fat = totalNutrition['fat'] ?? 0;
    final saturatedFat = totalNutrition['saturatedFat'] ?? 0;
    final carbs = totalNutrition['carbohydrates'] ?? 0;
    final sugars = totalNutrition['sugar'] ?? 0;
    final sodium = totalNutrition['sodium'] ?? 0;

    // Calculate energy in kJ (1 Cal = 4.184 kJ)
    final energyKJ = (calories * 4.184).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppConstants.borderColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppConstants.accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Nutrition Facts',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 2,
            color: AppConstants.borderColor,
          ),
          const SizedBox(height: 12),
          _buildNutritionRow(
            theme,
            'ENERGY',
            '${energyKJ}kJ (${calories.round()}Cal)',
            isHeader: true,
          ),
          const SizedBox(height: 8),
          _buildNutritionRow(
            theme,
            'PROTEIN',
            '${protein.toStringAsFixed(1)}g',
          ),
          _buildNutritionRow(theme, 'FAT, TOTAL', '${fat.toStringAsFixed(1)}g'),
          _buildNutritionRowIndented(
            theme,
            '- SATURATED',
            '${saturatedFat.toStringAsFixed(1)}g',
          ),
          _buildNutritionRow(
            theme,
            'CARBOHYDRATE',
            '${carbs.toStringAsFixed(1)}g',
          ),
          _buildNutritionRowIndented(
            theme,
            '- SUGARS',
            '${sugars.toStringAsFixed(1)}g',
          ),
          _buildNutritionRow(theme, 'SODIUM', '${sodium.round()}mg'),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 1,
            color: AppConstants.borderColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(
    ThemeData theme,
    String label,
    String value, {
    bool isHeader = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
              fontSize: isHeader ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isHeader ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRowIndented(
    ThemeData theme,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppConstants.secondaryTextColor,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppConstants.secondaryTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
