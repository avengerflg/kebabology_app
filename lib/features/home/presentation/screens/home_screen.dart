// lib/features/home/presentation/screens/home_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kebabologist_app/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                                    ),
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
                                    ),
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
      SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: AppConstants.backgroundColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildEnhancedHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: 80, // Changed from double.infinity to 80 for icon size
          height: 80, // Changed from 120 to 80 to make it square
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.9),
                AppConstants.surfaceColor.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20), // Reduced from 24 to 20
            boxShadow: [
              BoxShadow(
                color: AppConstants.accentColor.withOpacity(0.15),
                blurRadius: 20, // Reduced from 30 to 20
                offset: const Offset(0, 8), // Reduced from 10 to 8
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                blurRadius: 15, // Reduced from 20 to 15
                offset: const Offset(0, -3), // Reduced from -5 to -3
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 0),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // Reduced from 16 to 12
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'KEBABOLOGIST',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: screenWidth < 380 ? 1.0 : 2.0,
              fontSize: screenWidth < 380 ? 36 : 44,
              color: Colors.white,
              height: 1.0,
              shadows: [
                Shadow(
                  offset: const Offset(3, 3),
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(0.5),
                ),
                Shadow(
                  offset: const Offset(-1, -1),
                  blurRadius: 4.0,
                  color: Colors.black.withOpacity(0.3),
                ),
                Shadow(
                  offset: const Offset(0, 0),
                  blurRadius: 15.0,
                  color: AppConstants.accentColor.withOpacity(0.4),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(height: 16),
        // Added background container for social buttons
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3), // Semi-transparent background
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                context: context,
                icon: FontAwesomeIcons.tiktok,
                color: Colors.white,
                url: 'https://www.tiktok.com/@ox_show?_t=8qxaraa9ruq&_r=1',
              ),
              const SizedBox(width: 20),
              _buildSocialButton(
                context: context,
                icon: FontAwesomeIcons.instagram,
                color: Colors.white,
                url: 'https://www.instagram.com/ox_show2000',
              ),
              const SizedBox(width: 20),
              _buildSocialButton(
                context: context,
                icon: FontAwesomeIcons.youtube,
                color: Colors.white,
                url: 'https://youtube.com/@oxshow2000?si=278jG7V-G1a4Y6hs',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      },
      child: Container(
        width: 50,
        height: 36,
        // Remove the decoration to remove the background
        // decoration: BoxDecoration(
        //   color: Colors.red,
        //   borderRadius: BorderRadius.circular(8),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.2),
        //       blurRadius: 4,
        //       offset: const Offset(0, 2),
        //     ),
        //   ],
        // ),
        alignment: Alignment.center,
        child: FaIcon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _buildEnhancedFeaturesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1, // Adjust this value to make it smaller or larger
          child: _buildEnhancedHeroCard(
            context,
            title: 'Kebab Calorie Calculator',
            subtitle:
                'Track nutrition & make informed choices for your kebabs.',
            icon: FontAwesomeIcons.calculator,
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
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildEnhancedSecondaryCard(
                context,
                title: 'Kebabalogue',
                subtitle:
                    'The most detailed study conducted in the country on kebab shops. Come check out the shops and their ratings! Coming soon',
                icon: FontAwesomeIcons.mapLocationDot,
                primaryColor: const Color(0xFF2196F3),
                isComingSoon: true,
                onTap: () => _showEnhancedComingSoonDialog(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildEnhancedSecondaryCard(
                context,
                title: 'Fresh Tomatoes',
                subtitle:
                    'Kebab reviews - have your say on your most liked/disliked kebab shops that must be approved by me before publicly being posted. No fake reviews here!',
                icon: FontAwesomeIcons.star,
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
    final screenWidth = MediaQuery.of(context).size.width;

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
            color: AppConstants.accentColor.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
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
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.all(screenWidth < 380 ? 16 : 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.08), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth < 380 ? 56 : 64,
                  height: screenWidth < 380 ? 56 : 64,
                  alignment: Alignment.center,
                  child: title == 'Kebab Calorie Calculator'
                      ? Image.asset(
                          'assets/images/icon.png',
                          width: screenWidth < 380 ? 40 : 48,
                          height: screenWidth < 380 ? 40 : 48,
                          fit: BoxFit.contain,
                        )
                      : FaIcon(
                          icon,
                          color: Colors.white,
                          size: screenWidth < 380 ? 36 : 40,
                        ),
                ),
                SizedBox(width: screenWidth < 380 ? 12 : 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          fontSize: screenWidth < 380
                              ? 15
                              : 18, // Reduced from 18:22
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.92),
                          height: 1.5,
                          fontSize: screenWidth < 380 ? 12 : 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.85),
                    size: 18,
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
      height: 210,
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppConstants.borderColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
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
          splashColor: primaryColor.withOpacity(0.1),
          highlightColor: primaryColor.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.5), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.15),
                        primaryColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: FaIcon(icon, color: primaryColor, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textColor,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontSize: 9,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.visible,
                ),
                if (isComingSoon) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.goldAccent.withOpacity(0.2),
                          AppConstants.goldAccent.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppConstants.goldAccent.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: AppConstants.goldAccent,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 8),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: AppConstants.goldAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/splash_logo.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Powered by Fettayleh Foods',
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
      barrierColor: Colors.black.withOpacity(0.7),
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
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
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
                        AppConstants.goldAccent.withOpacity(0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.goldAccent.withOpacity(0.4),
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
                      shadowColor: AppConstants.accentColor.withOpacity(0.3),
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
