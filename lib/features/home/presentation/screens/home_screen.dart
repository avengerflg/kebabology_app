import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import '../../../calorie_calculator/presentation/screens/calculator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutBack,
    );
    _cardAnimation = CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutQuart,
    );

    // Start animations
    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          // Enhanced background with animated gradients
          ..._buildAnimatedBackground(screenHeight, screenWidth),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            const SizedBox(height: 32),
                            AnimatedBuilder(
                              animation: _headerAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                    0,
                                    30 * (1 - _headerAnimation.value),
                                  ),
                                  child: Opacity(
                                    opacity: _headerAnimation.value.clamp(
                                      0.0,
                                      1.0,
                                    ), // Fix opacity
                                    child: _buildEnhancedHeader(context),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                            AnimatedBuilder(
                              animation: _cardAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                    0,
                                    50 * (1 - _cardAnimation.value),
                                  ),
                                  child: Opacity(
                                    opacity: _cardAnimation.value.clamp(
                                      0.0,
                                      1.0,
                                    ), // Fix opacity
                                    child: _buildEnhancedFeaturesSection(
                                      context,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildEnhancedFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedBackground(
    double screenHeight,
    double screenWidth,
  ) {
    return [
      // Only use the background image with blur
      SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Blur overlay with a slight tint for readability
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Decreased blur
              child: Container(
                color: AppConstants.backgroundColor.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildEnhancedHeader(BuildContext context) {
    return Column(
      children: [
        // Enhanced logo with glassmorphism effect, now square
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.9),
                AppConstants.surfaceColor.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              24,
            ), // Square with rounded corners
            boxShadow: [
              BoxShadow(
                color: AppConstants.accentColor.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.9),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              5,
            ), // Add padding to make image smaller
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.contain,
                width: 80,
                height: 80,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Enhanced title with better gradient
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppConstants.textColor,
              AppConstants.accentColor,
              AppConstants.textColor.withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Kebabology',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              fontSize: 36,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.accentColor.withValues(alpha: 0.1),
                AppConstants.accentColor.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Text(
            'Make Kebabs Great Again',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white, // Changed from gold accent to white
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppConstants.accentColor, AppConstants.goldAccent],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Explore Features',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppConstants.textColor,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildEnhancedHeroCard(
          context,
          title: 'Calorie Counter',
          subtitle: 'Track nutrition & make informed choices for your kebabs.',
          icon: Icons.calculate_outlined,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CalculatorScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOutCubic)),
                        ),
                        child: child,
                      );
                    },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildEnhancedSecondaryCard(
                context,
                title: 'Kebabalogue',
                subtitle: 'Discover kebab types',
                icon: Icons.menu_book_outlined,
                primaryColor: const Color(0xFF4CAF50),
                isComingSoon: true,
                onTap: () => _showEnhancedComingSoonDialog(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildEnhancedSecondaryCard(
                context,
                title: 'Kebab Reviews',
                subtitle: 'Share your ratings',
                icon: Icons.star_border_purple500_outlined,
                primaryColor: const Color(0xFFE91E63),
                isComingSoon: true,
                onTap: () => _showEnhancedComingSoonDialog(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEnhancedHeroCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppConstants.accentColor, AppConstants.secondaryAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppConstants.accentColor.withValues(alpha: 0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.white.withValues(alpha: 0.1),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedSecondaryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color primaryColor,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return Container(
      height: 180, // Reduced height to prevent overflow
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppConstants.borderColor.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: primaryColor.withValues(alpha: 0.1),
          highlightColor: primaryColor.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.all(16), // Reduced padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14), // Reduced padding
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withValues(alpha: 0.15),
                        primaryColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16), // Slightly smaller
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 28,
                  ), // Slightly smaller
                ),
                const SizedBox(height: 12), // Reduced spacing
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    // Changed to titleSmall
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textColor,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // Reduced spacing
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontSize: 11, // Slightly smaller
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isComingSoon) ...[
                  const SizedBox(height: 8), // Reduced spacing
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10, // Reduced padding
                      vertical: 3, // Reduced padding
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.goldAccent.withValues(alpha: 0.2),
                          AppConstants.goldAccent.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Slightly smaller
                      border: Border.all(
                        color: AppConstants.goldAccent.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: AppConstants.goldAccent,
                        fontSize: 9, // Smaller font
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 8), // Add space when no badge
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      decoration: BoxDecoration(
        // Removed background color for transparency
        border: Border(
          top: BorderSide(
            color: AppConstants.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppConstants.goldAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('🇦🇺', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 12),
          Text(
            'Proudly Australian Made',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.goldAccent,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  void _showEnhancedComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: AppConstants.surfaceColor,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.goldAccent,
                        AppConstants.goldAccent.withValues(alpha: 0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.goldAccent.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Text('🚀', style: TextStyle(fontSize: 36)),
                ),
                const SizedBox(height: 24),
                Text(
                  'Feature Coming Soon!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textColor,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "We're crafting something amazing! This feature will be available in our next update.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      shadowColor: AppConstants.accentColor.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    child: Text(
                      'Got It!',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
