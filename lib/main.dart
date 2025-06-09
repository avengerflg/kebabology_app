import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kebabologist_app/core/theme/app_theme.dart';
import 'package:kebabologist_app/features/calorie_calculator/presentation/providers/calculator_provider.dart';
import 'package:kebabologist_app/features/home/presentation/screens/home_screen.dart';
import 'package:kebabologist_app/core/services/connectivity_service.dart';
import 'package:kebabologist_app/core/services/analytics_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await _initializeServices();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

Future<void> _initializeServices() async {
  try {
    await ConnectivityService.instance.initialize();
    await AnalyticsService.instance.initialize();
  } catch (e) {
    debugPrint('Service initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityService.instance),
      ],
      child: MaterialApp(
        title: 'Kebabologist',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false, // ✅ Removed debug banner
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(
                MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
              ),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
