// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.accentColor,
        brightness: Brightness.light,
        primary: AppConstants.accentColor,
        secondary: AppConstants.secondaryAccent,
        surface: AppConstants.surfaceColor,
        error: AppConstants.errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppConstants.textColor,
        onError: Colors.white,
      ),

      primarySwatch: _createMaterialColor(AppConstants.accentColor),
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      fontFamily: 'Inter',

      // Typography
      textTheme: const TextTheme(
        // Display Styles
        displayLarge: TextStyle(
          fontSize: AppConstants.fontSizeDisplay + 8,
          fontWeight: FontWeight.w900,
          color: AppConstants.textColor,
          letterSpacing: -1.0,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontSize: AppConstants.fontSizeDisplay,
          fontWeight: FontWeight.w800,
          color: AppConstants.textColor,
          letterSpacing: -0.8,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          fontSize: AppConstants.fontSizeHeading + 4,
          fontWeight: FontWeight.w700,
          color: AppConstants.textColor,
          letterSpacing: -0.6,
          height: 1.2,
        ),

        // Headlines - refined and less aggressive
        headlineLarge: TextStyle(
          fontSize: AppConstants.fontSizeHeading,
          fontWeight: FontWeight.w800,
          color: AppConstants.textColor,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeXXXL,
          fontWeight: FontWeight.w700,
          color: AppConstants.textColor,
          letterSpacing: -0.4,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontSize: AppConstants.fontSizeXXL,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: -0.3,
          height: 1.3,
        ),

        // Title text - clean and readable
        titleLarge: TextStyle(
          fontSize: AppConstants.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: -0.2,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: AppConstants.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: -0.1,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: AppConstants.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: 0,
          height: 1.4,
        ),

        // Body text - optimal for reading
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeL,
          fontWeight: FontWeight.w500,
          color: AppConstants.textColor,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppConstants.textColor,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: AppConstants.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppConstants.secondaryTextColor,
          height: 1.4,
        ),

        // Labels - subtle and clean
        labelLarge: TextStyle(
          fontSize: AppConstants.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: AppConstants.fontSizeS,
          fontWeight: FontWeight.w600,
          color: AppConstants.textColor,
          letterSpacing: 0.2,
        ),
        labelSmall: TextStyle(
          fontSize: AppConstants.fontSizeXS,
          fontWeight: FontWeight.w600,
          color: AppConstants.secondaryTextColor,
          letterSpacing: 0.3,
        ),
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: AppConstants.fontSizeXL,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppConstants.cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.accentColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppConstants.accentColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXXL,
            vertical: AppConstants.paddingL,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
            color: AppConstants.accentColor,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.accentColor,
          side: const BorderSide(color: AppConstants.accentColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXXL,
            vertical: AppConstants.paddingL,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
            color: AppConstants.accentColor,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(
            color: AppConstants.borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(
            color: AppConstants.borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(
            color: AppConstants.accentColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(
            color: AppConstants.errorColor,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingL,
          vertical: AppConstants.paddingM,
        ),
        hintStyle: const TextStyle(
          color: AppConstants.lightTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppConstants.accentColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: AppConstants.accentColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusS / 2),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppConstants.accentColor;
          }
          return AppConstants.borderColor;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppConstants.accentColor,
        inactiveTrackColor: AppConstants.borderColor,
        thumbColor: AppConstants.accentColor,
        overlayColor: AppConstants.accentColor.withValues(alpha: 0.2),
        valueIndicatorColor: AppConstants.accentColor,
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppConstants.dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppConstants.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXXL),
          ),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppConstants.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXXXL),
        ),
        elevation: 20,
        shadowColor: Colors.black.withValues(alpha: 0.2),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppConstants.lightTextColor;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppConstants.accentColor;
          }
          return AppConstants.borderColor;
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppConstants.surfaceColor,
        selectedColor: AppConstants.accentColor.withValues(alpha: 0.1),
        disabledColor: AppConstants.borderColor,
        labelStyle: const TextStyle(
          color: AppConstants.textColor,
          fontSize: AppConstants.fontSizeS,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppConstants.secondaryTextColor,
          fontSize: AppConstants.fontSizeS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        side: BorderSide(
          color: AppConstants.borderColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.accentColor,
        linearTrackColor: AppConstants.borderColor,
        circularTrackColor: AppConstants.borderColor,
      ),

      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};

    // Fixed deprecated color component accessors
    final int r = (color.r * 255.0).round() & 0xff;
    final int g = (color.g * 255.0).round() & 0xff;
    final int b = (color.b * 255.0).round() & 0xff;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.toARGB32(), swatch);
  }
}
