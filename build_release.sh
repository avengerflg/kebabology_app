#!/bin/bash

echo "🚀 Building Kebabologist for Production..."

# Clean previous builds
flutter clean
flutter pub get

# Build for Android
echo "📱 Building Android APK..."
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

echo "📱 Building Android App Bundle..."
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info

# Build for iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Building iOS..."
    flutter build ios --release --obfuscate --split-debug-info=build/debug-info
fi

echo "✅ Build complete!"
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
echo "AAB: build/app/outputs/bundle/release/app-release.aab"
