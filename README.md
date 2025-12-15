# Stargazing Social Community

A Flutter mobile application that connects astronomy enthusiasts, enabling them to share observations, coordinate viewing sessions, and build a vibrant community of stargazers.

## Features

### 🔐 Authentication
- Email/password login and registration
- Password reset functionality
- Secure authentication with Firebase Auth
- Persistent login sessions

### 📱 Social Feed
- Share stargazing observations and astrophotography
- Upload images with descriptions
- Tag observation locations and equipment used
- Like and comment on posts
- Pull-to-refresh for latest content

### 👤 User Profiles
- Customizable profile with picture and bio
- List astronomy interests (planets, deep sky, astrophotography, etc.)
- Equipment inventory (telescopes, cameras, mounts)
- Location for finding nearby stargazers
- Observation statistics and history

### 📅 Events
- Browse upcoming astronomical events (meteor showers, eclipses, ISS passes)
- Create and manage community meetup events
- RSVP to events
- View event details with date, time, location, and attendee list

### 👥 Groups & Communities
- Create and join interest-based groups
- Local astronomy clubs
- Equipment-specific communities
- Group discussions and posts

### 💬 Real-time Chat
- Direct messaging between users
- Group chat within communities
- Real-time message delivery
- Message timestamps and read receipts

## Tech Stack

- **Flutter 3.x** with Dart
- **Firebase Suite**:
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage
  - Firebase Cloud Messaging
- **State Management**: flutter_bloc
- **Navigation**: go_router
- **Architecture**: Clean Architecture principles
- **Design**: Material 3 with dark theme optimized for nighttime viewing

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/                      # App-level configuration
│   ├── app.dart             # Main app widget
│   └── routes.dart          # Route configuration
├── core/                     # Core utilities and services
│   ├── constants/           # App-wide constants
│   ├── theme/               # Theme configuration
│   ├── utils/               # Helper utilities
│   └── services/            # Core services (Firebase, Location)
├── data/                     # Data layer
│   ├── models/              # Data models
│   ├── repositories/        # Repository implementations
│   └── providers/           # Data providers
├── features/                 # Feature modules
│   ├── auth/                # Authentication
│   ├── feed/                # Social feed
│   ├── events/              # Events management
│   ├── groups/              # Groups & communities
│   ├── chat/                # Real-time messaging
│   └── profile/             # User profiles
└── shared/                   # Shared components
    ├── widgets/             # Reusable widgets
    └── extensions/          # Dart extensions
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase account
- Android Studio / Xcode for mobile development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/411221220-dotcom/ideal-giggle.git
   cd ideal-giggle
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**

   #### Android
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add an Android app to your Firebase project
   - Download `google-services.json`
   - Place it in `android/app/`
   
   #### iOS
   - Add an iOS app to your Firebase project
   - Download `GoogleService-Info.plist`
   - Place it in `ios/Runner/`

4. **Configure Firebase Services**
   
   Enable the following in Firebase Console:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Firebase Storage
   - Cloud Messaging (optional for push notifications)

5. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Security Rules

After setting up Firebase, configure security rules for Firestore and Storage:

#### Firestore Rules (Basic Example)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId;
    }
    // Add more rules for events, groups, messages, etc.
  }
}
```

#### Storage Rules (Basic Example)
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

## Development

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Building for Production

**Android**
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

## Theme

The app features a dark theme optimized for nighttime use with a deep space-inspired color palette:
- **Primary**: Deep purple/indigo (#1a1a2e)
- **Accent**: Cosmic red (#e94560)
- **Background**: Near black (#0f0f1a)
- **Surface**: Dark grey (#16213e)

High contrast ensures readability in low-light conditions, perfect for stargazing sessions.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Screenshots

_Screenshots will be added as features are implemented_

### Authentication
- Login Screen
- Sign Up Screen
- Forgot Password

### Main Features
- Social Feed
- Event Listings
- Group Browsing
- Chat Interface
- User Profile

## Roadmap

- [ ] Implement offline mode support
- [ ] Add weather integration for observing conditions
- [ ] Integration with astronomy APIs (NASA, Sky Maps)
- [ ] AR features for constellation identification
- [ ] Advanced search and filtering
- [ ] Push notifications for events and messages
- [ ] Social sharing to external platforms

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

**Happy Stargazing! 🌟🔭**
