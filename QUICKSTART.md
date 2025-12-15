# Quick Start Guide

Get the Stargazing Social Community app up and running in minutes!

## Prerequisites

Before you begin, ensure you have:
- ✅ Flutter SDK (3.0.0 or higher)
- ✅ Dart SDK (3.0.0 or higher)
- ✅ Android Studio / Xcode
- ✅ Firebase account
- ✅ Git

## Step 1: Clone the Repository

```bash
git clone https://github.com/411221220-dotcom/ideal-giggle.git
cd ideal-giggle
```

## Step 2: Install Dependencies

```bash
flutter pub get
```

## Step 3: Configure Firebase

### Quick Setup (5 minutes)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Add Android and/or iOS apps
4. Download configuration files:
   - Android: `google-services.json` → place in `android/app/`
   - iOS: `GoogleService-Info.plist` → add to Xcode project

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

## Step 4: Run the App

```bash
# For Android
flutter run

# For iOS
flutter run

# For web (if enabled)
flutter run -d chrome
```

## Step 5: Explore Features

The app includes:
- 🔐 **Authentication**: Sign up and login
- 📱 **Feed**: View and create posts
- 📅 **Events**: Browse astronomical events
- 👥 **Groups**: Join communities
- 💬 **Chat**: Real-time messaging
- 👤 **Profile**: Manage your profile

## Project Structure

```
lib/
├── app/              # App configuration & routing
├── core/             # Constants, theme, services
├── data/             # Models, repositories
├── features/         # Feature modules (auth, feed, etc.)
└── shared/           # Reusable widgets & extensions
```

## Common Commands

```bash
# Run app
flutter run

# Run tests
flutter test

# Run linter
flutter analyze

# Format code
flutter format .

# Clean build
flutter clean
```

## Development Workflow

1. Create a feature branch
2. Implement your feature
3. Run tests and linter
4. Commit and push
5. Open a pull request

## Troubleshooting

### Firebase not initialized
- Ensure configuration files are in the correct locations
- Check Firebase.initializeApp() in main.dart

### Dependencies error
```bash
flutter clean
flutter pub get
```

### Platform-specific issues
```bash
# Android
cd android && ./gradlew clean

# iOS
cd ios && pod install
```

## Next Steps

1. Configure Firebase Authentication
2. Set up Firestore database
3. Enable Firebase Storage
4. Customize theme colors
5. Add your own features!

## Resources

- 📖 [README.md](README.md) - Project overview
- 🔥 [FIREBASE_SETUP.md](FIREBASE_SETUP.md) - Detailed Firebase setup
- 🏗️ [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Architecture guide
- 🤝 [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines

## Need Help?

- Check existing documentation
- Open an issue on GitHub
- Review Flutter and Firebase docs

Happy coding! 🌟🔭
