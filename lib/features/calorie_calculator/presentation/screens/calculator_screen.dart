// lib/features/calorie_calculator/presentation/screens/calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/component_selector.dart';
import '../widgets/weight_slider.dart';
import '../widgets/nutrition_display.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/kebab_component.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _scrollToNutrition() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Kebab Calorie Calculator',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.accentColor,
                AppConstants.accentColor.withValues(alpha: 0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.accentColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              if (!provider.hasSelections) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) =>
                          _buildClearDialog(dialogContext, provider),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppConstants.accentColor.withValues(alpha: 0.08),
                  Colors.grey.shade50,
                  Colors.white,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
            child: Consumer<CalculatorProvider>(
              builder: (context, provider, child) {
                return CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Header space for app bar
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            10,
                      ),
                    ),

                    // Welcome Hero Section
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Colors.grey.shade50.withValues(alpha: 0.8),
                                Colors.white.withValues(alpha: 0.95),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppConstants.accentColor.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 35,
                                offset: const Offset(0, 12),
                                spreadRadius: -8,
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 25,
                                offset: const Offset(0, 8),
                                spreadRadius: -5,
                              ),
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.7),
                                blurRadius: 15,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      AppConstants.surfaceColor.withValues(
                                        alpha: 0.3,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: AppConstants.accentColor.withValues(
                                      alpha: 0.2,
                                    ),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppConstants.accentColor
                                          .withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(0, -3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: Image.asset(
                                    'assets/images/logo.jpeg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Maybe she\'s born with it.\nMaybe it\'s Kebabaline',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                  height: 1.3,
                                  letterSpacing: -0.8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppConstants.accentColor.withValues(
                                        alpha: 0.15,
                                      ),
                                      AppConstants.accentColor.withValues(
                                        alpha: 0.08,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppConstants.accentColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppConstants.accentColor
                                          .withValues(alpha: 0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Let the Games Begin',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppConstants.accentColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Component Selectors
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            child: ComponentSelector(
                              type: ComponentType.bread,
                              components: provider.breadOptions,
                              selected: provider.selectedBread,
                              onSelectionChanged: (breadId) {
                                provider.selectBread(breadId);
                              },
                              allowMultiple: false,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildSectionCard(
                            child: ComponentSelector(
                              type: ComponentType.meat,
                              components: provider.meatOptions,
                              selected: provider.selectedMeats,
                              onSelectionChanged: (meatId) {
                                provider.toggleMeat(meatId);
                              },
                              allowMultiple: true,
                              maxSelections: 2,
                              errorMessage:
                                  provider.selectedMeats.isEmpty &&
                                      provider.hasSelections
                                  ? 'Select at least one meat'
                                  : provider.selectedMeats.length > 2
                                  ? 'Maximum 2 meats allowed'
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildSectionCard(
                            child: ComponentSelector(
                              type: ComponentType.salad,
                              components: provider.saladOptions,
                              selected: provider.selectedSalads,
                              onSelectionChanged: (saladId) {
                                provider.toggleSalad(saladId);
                              },
                              allowMultiple: true,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildSectionCard(
                            child: ComponentSelector(
                              type: ComponentType.sauce,
                              components: provider.sauceOptions,
                              selected: provider.selectedSauces,
                              onSelectionChanged: (sauceId) {
                                provider.toggleSauce(sauceId);
                              },
                              allowMultiple: true,
                              maxSelections: AppConstants.maxSauces,
                              errorMessage:
                                  provider.selectedSauces.length >
                                      AppConstants.maxSauces
                                  ? 'Maximum ${AppConstants.maxSauces} sauces allowed'
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildSectionCard(
                            child: WeightSlider(
                              weight: provider.kebabWeight,
                              onWeightChanged: (weight) {
                                provider.updateWeight(weight);
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ]),
                      ),
                    ),

                    // Nutrition Display
                    if (provider.hasValidSelections) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: NutritionDisplay(
                            totalNutrition: provider.totalNutrition,
                            nutritionByType: provider.nutritionByType,
                            isValid: provider.hasValidSelections,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    ],

                    // Calculate Button (if no valid selections)
                    if (!provider.hasValidSelections) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                          child: _buildCalculateButton(context, provider),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCalculateButton(
    BuildContext context,
    CalculatorProvider provider,
  ) {
    final theme = Theme.of(context);
    final hasMinimumSelections = provider.selectedBread != null;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasMinimumSelections
              ? [AppConstants.accentColor, AppConstants.secondaryAccent]
              : [Colors.grey.shade400, Colors.grey.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: hasMinimumSelections
            ? [
                BoxShadow(
                  color: AppConstants.accentColor.withValues(alpha: 0.4),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasMinimumSelections ? _scrollToNutrition : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasMinimumSelections
                      ? Icons.calculate_rounded
                      : Icons.info_outline,
                  color: Colors.white,
                  size: 26,
                ),
                const SizedBox(width: 14),
                Text(
                  hasMinimumSelections
                      ? 'Calculate Nutrition'
                      : 'Select bread to continue',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearDialog(BuildContext context, CalculatorProvider provider) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      elevation: 20,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants.accentColor.withValues(alpha: 0.15),
                  AppConstants.accentColor.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.refresh_rounded,
              color: AppConstants.accentColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Text('Clear All Selections'),
        ],
      ),
      content: const Text(
        'Are you sure you want to clear all your selections and start over?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          onPressed: () {
            provider.clearAllSelections();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: const Text('Clear All'),
        ),
      ],
    );
  }
}
