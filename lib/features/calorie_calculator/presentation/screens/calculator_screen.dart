import 'package:flutter/material.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/component_selector.dart';
import '../widgets/nutrition_display.dart';
import '../widgets/weight_slider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar
                SliverToBoxAdapter(child: _buildModernAppBar(context)),
                // Main Content
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildKebabBuilderCard(),
                      const SizedBox(height: 20),
                      _buildWeightAndNutritionRow(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppConstants.cardColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(14),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppConstants.textColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppConstants.gradientStart, AppConstants.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.accentColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('🧮', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kebab Calculator',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppConstants.textColor,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'Build your perfect kebab',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKebabBuilderCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.gradientStart, AppConstants.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text('🥙', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Build Your Kebab',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Select your favorite ingredients',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Ingredients
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildIngredientSection(
                  'Bread Base',
                  'bread',
                  Icons.bakery_dining_outlined,
                  AppConstants.goldAccent,
                  false,
                ),
                const SizedBox(height: 16),
                _buildIngredientSection(
                  'Protein Choice',
                  'meat',
                  Icons.restaurant_outlined,
                  AppConstants.accentColor,
                  false,
                ),
                const SizedBox(height: 16),
                _buildIngredientSection(
                  'Fresh Salads',
                  'salad',
                  Icons.eco_outlined,
                  const Color(0xFF38A169),
                  true,
                ),
                const SizedBox(height: 16),
                _buildIngredientSection(
                  'Signature Sauces',
                  'sauce',
                  Icons.water_drop_outlined,
                  const Color(0xFF3182CE),
                  true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientSection(
    String title,
    String category,
    IconData icon,
    Color color,
    bool isMultiSelect,
  ) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        // Get selection count for dynamic header
        int selectionCount = 0;
        if (category == 'salad') {
          selectionCount = provider.selectedSalads.length;
        } else if (category == 'sauce') {
          selectionCount = provider.selectedSauces.length;
        } else if (category == 'bread') {
          selectionCount = provider.selectedBread != null ? 1 : 0;
        } else if (category == 'meat') {
          selectionCount = provider.selectedMeat != null ? 1 : 0;
        }

        return Container(
          decoration: BoxDecoration(
            color: AppConstants.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selectionCount > 0
                  ? color.withValues(alpha: 0.3)
                  : AppConstants.borderColor,
              width: selectionCount > 0 ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fixed Row with proper wrapping
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppConstants.textColor,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (selectionCount > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$selectionCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          // Status text on new line to prevent overflow
                          if (category == 'sauce' &&
                              !provider.canSelectMoreSauces)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Maximum reached',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Multi-select badge with constrained width
                    if (isMultiSelect)
                      Container(
                        constraints: const BoxConstraints(maxWidth: 60),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 12,
                              color: color,
                            ),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                'Multi',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ComponentSelector(
                  title: '',
                  category: category,
                  isMultiSelect: isMultiSelect,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeightAndNutritionRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 768;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildWeightCard()),
              const SizedBox(width: 20),
              Expanded(child: _buildNutritionCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildWeightCard(),
              const SizedBox(height: 20),
              _buildNutritionCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildWeightCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppConstants.goldAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.scale_outlined,
                  color: AppConstants.goldAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Settings',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppConstants.textColor,
                      ),
                    ),
                    Text(
                      'Adjust serving size',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const WeightSlider(),
        ],
      ),
    );
  }

  Widget _buildNutritionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppConstants.gradientStart, AppConstants.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.accentColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nutrition Analysis',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Detailed breakdown',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const NutritionDisplay(),
        ],
      ),
    );
  }
}
