# 🥙 Kebabologist - OX Show Official App

<div align="center">
  <img src="assets/images/logo.jpeg" alt="Kebabologist Logo" width="120" height="120" style="border-radius: 20px;">
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
  [![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey.svg)](https://flutter.dev/)
</div>

## 📱 About

**Kebabologist** is the official mobile app for the OX Show, featuring Australia's first and most comprehensive kebab calorie calculator. Follow your favorite content creator while discovering the nutritional information of your favorite kebabs!

### ✨ Features

- 🧮 **Kebab Calorie Calculator** - Calculate exact calories based on your specific kebab and weight
- 📱 **Social Media Integration** - Direct links to OX Show's TikTok, Instagram, and YouTube
- 🏪 **Kebabalogue** _(Coming Soon)_ - Comprehensive kebab shop ratings and reviews
- ⭐ **Fresh Tomatoes** _(Coming Soon)_ - Authentic kebab shop reviews platform
- 🎨 **Modern UI/UX** - Beautiful, responsive design with smooth animations

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/kebabologist-app.git
   cd kebabologist-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── home/
│   │   └── presentation/
│   │       └── screens/
│   │           └── home_screen.dart
│   └── calorie_calculator/
│       └── presentation/
│           └── screens/
│               └── calculator_screen.dart
└── main.dart
```

## 📦 Dependencies

### Core Dependencies

- `flutter`: SDK
- `cupertino_icons`: iOS-style icons

### UI & Animation

- `font_awesome_flutter`: Social media icons
- `flutter_animate`: Smooth animations

### Functionality

- `url_launcher`: External link handling
- `shared_preferences`: Local data storage

### Development

- `flutter_test`: Testing framework
- `flutter_lints`: Code analysis

## 🎨 Design System

### Color Palette

- **Primary**: `#FF6B35` (Orange)
- **Secondary**: `#F7931E` (Gold)
- **Accent**: `#FFD700` (Gold Accent)
- **Background**: `#FAFAFA` (Light Grey)
- **Surface**: `#FFFFFF` (White)

### Typography

- **Headers**: Bold, modern sans-serif
- **Body**: Clean, readable font
- **Accent**: Stylized for branding

## 📱 Screenshots

| Home Screen                   | Calculator                                | Coming Soon                                 |
| ----------------------------- | ----------------------------------------- | ------------------------------------------- |
| ![Home](screenshots/home.png) | ![Calculator](screenshots/calculator.png) | ![Coming Soon](screenshots/coming_soon.png) |

## 🔧 Configuration

### Environment Setup

1. **Android Configuration**

   - Update `android/app/build.gradle`
   - Set minimum SDK version to 21
   - Configure app signing

2. **iOS Configuration**
   - Update `ios/Runner/Info.plist`
   - Set deployment target to iOS 12.0
   - Configure app icons and launch screens

### App Store Metadata

For detailed app store descriptions, keywords, and metadata, see [app_store_metadata.md](./app_store_metadata.md)

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

## 🚀 Deployment

### Android (Google Play Store)

```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended)
flutter build appbundle --release
```

### iOS (App Store)

```bash
# Build for iOS
flutter build ios --release

# Archive in Xcode
# Upload via Xcode or Application Loader
```

## 🌟 Features Roadmap

### Current Version (1.0.0)

- ✅ Kebab Calorie Calculator
- ✅ Social Media Integration
- ✅ Modern UI/UX Design

### Upcoming Features

- 🔄 **Kebabalogue** - Kebab shop database and ratings
- 🔄 **Fresh Tomatoes** - User review system
- 🔄 **Favorites** - Save your favorite kebabs
- 🔄 **Nutrition Tracking** - Daily calorie tracking
- 🔄 **Push Notifications** - New content alerts

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow [Flutter style guide](https://flutter.dev/docs/development/tools/formatting)
- Use `flutter analyze` to check code quality
- Write tests for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support & Contact

### OX Show Social Media

- 🎵 **TikTok**: [@ox_show](https://www.tiktok.com/@ox_show?_t=8qxaraa9ruq&_r=1)
- 📸 **Instagram**: [@ox_show2000](https://www.instagram.com/ox_show2000)
- 🎥 **YouTube**: [@oxshow2000](https://youtube.com/@oxshow2000?si=278jG7V-G1a4Y6hs)

### Technical Support

- 📧 **Email**: support@fettaylehfoods.com
- 🐛 **Issues**: [GitHub Issues](https://github.com/yourusername/kebabologist-app/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/kebabologist-app/discussions)

## 🙏 Acknowledgments

- **OX Show** - Content creation and brand
- **Fettayleh Foods** - Development and publishing
- **Flutter Community** - Amazing framework and resources
- **Contributors** - Thank you for your contributions!

## 📊 Stats

<div align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=yourusername&repo=kebabologist-app&show_icons=true&theme=default" alt="GitHub Stats">
</div>

---

<div align="center">
  <p>Made with ❤️ by <strong>Fettayleh Foods</strong></p>
  <p>Powered by <strong>Flutter</strong> 🚀</p>
</div>
