// lib/core/services/analytics_service.dart

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  static AnalyticsService get instance => _instance;
  AnalyticsService._internal();

  PackageInfo? _packageInfo;
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      _prefs = await SharedPreferences.getInstance();
      
      // Track app launch
      await _trackEvent('app_launch');
    } catch (e) {
      debugPrint('Analytics service initialization error: $e');
    }
  }

  Future<void> _trackEvent(String eventName, [Map<String, dynamic>? parameters]) async {
    if (kDebugMode) {
      debugPrint('Analytics Event: $eventName ${parameters ?? ''}');
    }
    
    // In production, you would send this to your analytics service
    // For now, we'll just store locally for debugging
    try {
      final events = _prefs?.getStringList('analytics_events') ?? [];
      events.add('${DateTime.now().toIso8601String()}: $eventName');
      await _prefs?.setStringList('analytics_events', events);
    } catch (e) {
      debugPrint('Analytics tracking error: $e');
    }
  }

  Future<void> trackKebabCalculation(Map<String, dynamic> kebabData) async {
    await _trackEvent('kebab_calculated', kebabData);
  }

  Future<void> trackFeatureAccess(String featureName) async {
    await _trackEvent('feature_accessed', {'feature': featureName});
  }

  String get appVersion => _packageInfo?.version ?? 'Unknown';
  String get buildNumber => _packageInfo?.buildNumber ?? 'Unknown';
}
