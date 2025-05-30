import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../../data/models/kebab_component.dart';

class ComponentSelector extends StatelessWidget {
  final String title;
  final String category;
  final bool isMultiSelect;

  const ComponentSelector({
    super.key,
    required this.title,
    required this.category,
    required this.isMultiSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        List<KebabComponent> components;

        switch (category) {
          case 'bread':
            components = provider.breads;
            break;
          case 'meat':
            components = provider.meats;
            break;
          case 'salad':
            components = provider.salads;
            break;
          case 'sauce':
            components = provider.sauces;
            break;
          default:
            components = [];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern section header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppConstants.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppConstants.accentColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(),
                    color: AppConstants.accentColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppConstants.textColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (category == 'sauce' && !provider.canSelectMoreSauces)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.goldAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'MAX',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Components list
            ...components.map(
              (component) =>
                  _buildModernComponentItem(context, provider, component),
            ),
            // Add calculation info
            _buildCalculationInfo(context, provider),
          ],
        );
      },
    );
  }

  Widget _buildCalculationInfo(
    BuildContext context,
    CalculatorProvider provider,
  ) {
    if (category == 'salad' && provider.selectedSalads.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF38A169).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF38A169).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, size: 16, color: Color(0xFF38A169)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                provider.getSaladSelectionText(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF38A169),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (category == 'sauce' && provider.selectedSauces.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppConstants.accentColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppConstants.accentColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 16,
              color: AppConstants.accentColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                provider.getSauceSelectionText(),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppConstants.accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  IconData _getCategoryIcon() {
    switch (category) {
      case 'bread':
        return Icons.bakery_dining_rounded;
      case 'meat':
        return Icons.set_meal_rounded;
      case 'salad':
        return Icons.eco_rounded;
      case 'sauce':
        return Icons.water_drop_rounded;
      default:
        return Icons.fastfood_rounded;
    }
  }

  Widget _buildModernComponentItem(
    BuildContext context,
    CalculatorProvider provider,
    KebabComponent component,
  ) {
    bool isSelected = false;

    if (isMultiSelect) {
      if (category == 'salad') {
        isSelected = provider.selectedSalads.contains(component);
      } else if (category == 'sauce') {
        isSelected = provider.selectedSauces.contains(component);
      }
    } else {
      if (category == 'bread') {
        isSelected = provider.selectedBread == component;
      } else if (category == 'meat') {
        isSelected = provider.selectedMeat == component;
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppConstants.accentColor.withValues(alpha: 0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppConstants.accentColor.withValues(alpha: 0.3)
              : AppConstants.borderColor,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              (category == 'sauce' &&
                  !provider.canSelectMoreSauces &&
                  !isSelected)
              ? null
              : () => _handleSelection(provider, component),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isSelected ? 14 : 12,
            ),
            child: Row(
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: isSelected ? 1.1 : 1.0,
                  child: isMultiSelect
                      ? Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppConstants.accentColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppConstants.accentColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        )
                      : Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppConstants.accentColor
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppConstants.accentColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 12,
                                )
                              : null,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    component.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? AppConstants.accentColor
                          : AppConstants.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSelection(CalculatorProvider provider, KebabComponent component) {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    switch (category) {
      case 'bread':
        provider.selectBread(component);
        break;
      case 'meat':
        provider.selectMeat(component);
        break;
      case 'salad':
        provider.toggleSalad(component);
        break;
      case 'sauce':
        provider.toggleSauce(component);
        break;
    }
  }
}
