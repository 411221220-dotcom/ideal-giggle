# Firebase Configuration Guide

This guide will help you set up Firebase for the Stargazing Social Community app.

## Prerequisites

- A Google account
- Flutter SDK installed
- Android Studio / Xcode for platform-specific setup

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `stargazing-social` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Add Android App

1. In Firebase Console, click the Android icon
2. Enter package name: `com.stargazingsocial.app`
3. Enter app nickname: `Stargazing Social Android`
4. Click "Register app"
5. Download `google-services.json`
6. Place the file in `android/app/` directory
7. Follow the setup instructions in Firebase Console

### Android Configuration

Update `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

Update `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21
        multiDexEnabled true
    }
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.3.1')
}
```

## Step 3: Add iOS App

1. In Firebase Console, click the iOS icon
2. Enter bundle ID: `com.stargazingsocial.app`
3. Enter app nickname: `Stargazing Social iOS`
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Open Xcode: `open ios/Runner.xcworkspace`
7. Drag `GoogleService-Info.plist` into the Runner folder in Xcode
8. Ensure "Copy items if needed" is checked

### iOS Configuration

Update `ios/Podfile`:
```ruby
platform :ios, '12.0'

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

## Step 4: Enable Firebase Services

### Authentication
1. Go to Authentication in Firebase Console
2. Click "Get started"
3. Enable "Email/Password" sign-in method

### Cloud Firestore
1. Go to Firestore Database
2. Click "Create database"
3. Start in test mode (change rules later)
4. Choose a location close to your users

### Firebase Storage
1. Go to Storage
2. Click "Get started"
3. Start in test mode (change rules later)

### Cloud Messaging (Optional)
1. Go to Cloud Messaging
2. Follow setup instructions for push notifications

## Step 5: Configure Security Rules

### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Posts collection
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId;
    }
    
    // Events collection
    match /events/{eventId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.organizerId;
    }
    
    // Groups collection
    match /groups/{groupId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid in resource.data.adminIds;
    }
    
    // Conversations and Messages
    match /conversations/{conversationId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participantIds;
      
      match /messages/{messageId} {
        allow read, write: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/conversations/$(conversationId)).data.participantIds;
      }
    }
  }
}
```

### Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Profile pictures
    match /profile_pictures/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Post images
    match /post_images/{postId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Event images
    match /event_images/{eventId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Group images
    match /group_images/{groupId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

## Step 6: Test Your Setup

Run the app:
```bash
flutter pub get
flutter run
```

Check for Firebase initialization in the logs.

## Troubleshooting

### Android Issues
- Ensure `google-services.json` is in `android/app/`
- Check that Google Services plugin is applied
- Clean and rebuild: `flutter clean && flutter pub get`

### iOS Issues
- Ensure `GoogleService-Info.plist` is added to Xcode project
- Run `cd ios && pod install`
- Clean build folder in Xcode

### Common Errors
- **Firebase not initialized**: Check that Firebase.initializeApp() is called in main.dart
- **Permission denied**: Update Firestore/Storage security rules
- **Package name mismatch**: Ensure package names match in Firebase Console and app config

## Next Steps

1. Set up Firebase indexes for complex queries
2. Enable Firebase Analytics
3. Configure Firebase Cloud Functions (if needed)
4. Set up Firebase Hosting for admin panel (optional)

## Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Documentation](https://firebase.google.com/docs)
