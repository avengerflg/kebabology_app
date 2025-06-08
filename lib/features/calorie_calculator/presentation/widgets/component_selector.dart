// lib/features/calorie_calculator/presentation/widgets/component_selector.dart

import 'package:flutter/material.dart';
import '../../data/models/kebab_component.dart';
import '../../../../core/constants/app_constants.dart';

class ComponentSelector extends StatelessWidget {
  final ComponentType type;
  final List<KebabComponent> components;
  final dynamic selected;
  final Function(String) onSelectionChanged;
  final bool allowMultiple;
  final int? maxSelections;
  final String? errorMessage;

  const ComponentSelector({
    super.key,
    required this.type,
    required this.components,
    required this.selected,
    required this.onSelectionChanged,
    this.allowMultiple = false,
    this.maxSelections,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: errorMessage != null
              ? AppConstants.accentColor.withOpacity(0.5)
              : AppConstants.borderColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: errorMessage != null
                ? AppConstants.accentColor.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
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
              color: _getHeaderColor().withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppConstants.borderColor.withOpacity(0.3),
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
                        color: _getHeaderColor(),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      type.displayName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (type == ComponentType.sauce &&
                        maxSelections != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.secondaryTextColor.withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Max $maxSelections',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppConstants.secondaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                _buildSelectionIndicator(theme),
              ],
            ),
          ),
          if (errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppConstants.accentColor.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: AppConstants.accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 20,
                    color: AppConstants.accentColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: components.map((component) {
                final isSelected = _isComponentSelected(component.id);
                final isDisabled = _isSelectionDisabled(component.id);

                return _buildComponentChip(
                  context,
                  component,
                  isSelected,
                  isDisabled,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getHeaderColor() {
    switch (type) {
      case ComponentType.bread:
        return AppConstants.goldAccent;
      case ComponentType.meat:
        return AppConstants.accentColor;
      case ComponentType.salad:
        return Colors.green;
      case ComponentType.sauce:
        return AppConstants.secondaryAccent;
    }
  }

  Widget _buildSelectionIndicator(ThemeData theme) {
    final count = _getSelectionCount();
    if (count == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getHeaderColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getHeaderColor().withOpacity(0.3), width: 1),
      ),
      child: Text(
        count.toString(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: _getHeaderColor(),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  int _getSelectionCount() {
    if (selected == null) return 0;
    if (selected is List) return (selected as List).length;
    return 1;
  }

  bool _isComponentSelected(String componentId) {
    if (selected == null) return false;
    if (selected is List) {
      return (selected as List).contains(componentId);
    }
    return selected == componentId;
  }

  bool _isSelectionDisabled(String componentId) {
    if (!allowMultiple) return false;
    if (maxSelections == null) return false;
    if (_isComponentSelected(componentId)) return false;

    final currentCount = _getSelectionCount();
    return currentCount >= maxSelections!;
  }

  Widget _buildComponentChip(
    BuildContext context,
    KebabComponent component,
    bool isSelected,
    bool isDisabled,
  ) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : () => onSelectionChanged(component.id),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? _getHeaderColor().withOpacity(0.15)
                : AppConstants.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? _getHeaderColor()
                  : AppConstants.borderColor.withOpacity(0.5),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == ComponentType.bread)
                Radio<String>(
                  value: component.id,
                  groupValue: selected as String?,
                  onChanged: isDisabled
                      ? null
                      : (_) => onSelectionChanged(component.id),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              else
                Checkbox(
                  value: isSelected,
                  onChanged: isDisabled
                      ? null
                      : (_) => onSelectionChanged(component.id),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              const SizedBox(width: 4),
              Text(
                component.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isDisabled
                      ? AppConstants.secondaryTextColor.withOpacity(0.5)
                      : AppConstants.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
