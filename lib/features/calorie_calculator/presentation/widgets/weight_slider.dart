// lib/features/calorie_calculator/presentation/widgets/weight_slider.dart

import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class WeightSlider extends StatelessWidget {
  final double weight;
  final Function(double) onWeightChanged;

  const WeightSlider({
    super.key,
    required this.weight,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppConstants.borderColor.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstants.goldAccent.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppConstants.borderColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppConstants.goldAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Weight',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.goldAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppConstants.goldAccent.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${weight.round()}g',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppConstants.goldAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppConstants.goldAccent,
                    inactiveTrackColor: AppConstants.goldAccent.withValues(
                      alpha: 0.2,
                    ),
                    thumbColor: AppConstants.goldAccent,
                    overlayColor: AppConstants.goldAccent.withValues(
                      alpha: 0.2,
                    ),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 12,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 20,
                    ),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: weight,
                    min: 200,
                    max: 800,
                    divisions: 60,
                    onChanged: onWeightChanged,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '200g',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                      ),
                    ),
                    Text(
                      'Standard: ${AppConstants.standardKebabWeight.round()}g',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '800g',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                if (weight != AppConstants.standardKebabWeight) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getWeightDifferenceColor().withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getWeightDifferenceText(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getWeightDifferenceColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getWeightDifferenceColor() {
    final difference = weight - AppConstants.standardKebabWeight;
    if (difference > 0) return Colors.orange;
    if (difference < 0) return Colors.blue;
    return AppConstants.secondaryTextColor;
  }

  String _getWeightDifferenceText() {
    final difference = weight - AppConstants.standardKebabWeight;
    if (difference > 0) {
      return '+${difference.round()}g from standard';
    }
    if (difference < 0) {
      return '${difference.round()}g from standard';
    }
    return 'Standard weight';
  }
}
