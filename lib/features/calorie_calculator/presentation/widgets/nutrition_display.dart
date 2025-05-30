import 'package:flutter/material.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:kebabology_app/core/utils/calculations.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../../data/models/nutrition_data.dart';

class NutritionDisplay extends StatelessWidget {
  const NutritionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        final nutrition = provider.totalNutrition;
        final hasSelection =
            provider.selectedBread != null ||
            provider.selectedMeat != null ||
            provider.selectedSalads.isNotEmpty ||
            provider.selectedSauces.isNotEmpty;

        if (!hasSelection) {
          return _buildEmptyState();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainNutrients(nutrition),
            const SizedBox(height: 16),
            _buildDetailedNutrients(nutrition),
            const SizedBox(height: 16),
            _buildResetButton(provider),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 48,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'Select ingredients to see nutrition facts',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMainNutrients(NutritionData nutrition) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppConstants.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNutrientColumn(
            'CALORIES',
            '${CalculationUtils.roundToOneDecimal(nutrition.calories)}',
            'kcal',
          ),
          _buildNutrientColumn(
            'PROTEIN',
            '${CalculationUtils.roundToOneDecimal(nutrition.protein)}',
            'g',
          ),
          _buildNutrientColumn(
            'CARBS',
            '${CalculationUtils.roundToOneDecimal(nutrition.carbohydrates)}',
            'g',
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientColumn(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppConstants.accentColor,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(fontSize: 12, color: AppConstants.textColor),
        ),
      ],
    );
  }

  Widget _buildDetailedNutrients(NutritionData nutrition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detailed Nutrition Facts',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
          ),
        ),
        const SizedBox(height: 8),
        _buildNutrientRow('Total Fat', nutrition.fat, 'g'),
        _buildNutrientRow('Dietary Fiber', nutrition.fiber, 'g'),
        _buildNutrientRow('Total Sugars', nutrition.sugar, 'g'),
        _buildNutrientRow('Sodium', nutrition.sodium, 'mg'),
      ],
    );
  }

  Widget _buildNutrientRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppConstants.textColor),
          ),
          Text(
            '${CalculationUtils.roundToOneDecimal(value)}$unit',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppConstants.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetButton(CalculatorProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: provider.reset,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Reset Calculator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
