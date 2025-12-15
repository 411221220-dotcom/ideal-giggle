# Stargazing Social - Project Structure

This document provides an overview of the complete project structure and organization.

## Overview

The Stargazing Social Community app follows **Clean Architecture** principles with a feature-based organization using **flutter_bloc** for state management and **go_router** for navigation.

## Root Directory

```
ideal-giggle/
├── README.md                      # Project overview and setup instructions
├── CONTRIBUTING.md                # Contribution guidelines
├── FIREBASE_SETUP.md             # Firebase configuration guide
├── LICENSE                        # MIT License
├── PROJECT_STRUCTURE.md          # This file
├── pubspec.yaml                   # Dependencies and project configuration
├── analysis_options.yaml          # Dart linting rules
├── .gitignore                     # Git ignore rules
├── android/                       # Android platform files
│   └── app/
│       └── google-services.json.example
├── ios/                           # iOS platform files
│   └── Runner/
│       └── GoogleService-Info.plist.example
├── test/                          # Test files
│   └── widget_test.dart
└── lib/                           # Main application code
```

## Lib Directory Structure

### App Layer (`lib/app/`)
- `app.dart` - Main application widget with theme and providers
- `routes.dart` - Route configuration using go_router

### Core Layer (`lib/core/`)

#### Constants (`lib/core/constants/`)
- `app_constants.dart` - App-wide constants (collections, limits, interests)
- `api_constants.dart` - API endpoints and external service URLs

#### Theme (`lib/core/theme/`)
- `app_theme.dart` - Material 3 dark theme optimized for stargazing
- `app_colors.dart` - Color palette with space-inspired colors

#### Utils (`lib/core/utils/`)
- `helpers.dart` - Utility functions (date formatting, validation, dialogs)

#### Services (`lib/core/services/`)
- `firebase_service.dart` - Firebase initialization and configuration
- `location_service.dart` - Location permission and GPS handling

### Data Layer (`lib/data/`)

#### Models (`lib/data/models/`)
- `user_model.dart` - User profile data model
- `post_model.dart` - Social post data model
- `event_model.dart` - Astronomical event/meetup model
- `group_model.dart` - Community group model
- `message_model.dart` - Chat message model

#### Repositories (`lib/data/repositories/`)
- `auth_repository.dart` - Authentication operations
- `post_repository.dart` - Post CRUD operations
- `event_repository.dart` - Event CRUD operations
- `group_repository.dart` - Group CRUD operations
- `chat_repository.dart` - Messaging operations

#### Providers (`lib/data/providers/`)
- `firebase_providers.dart` - Firebase instance providers

### Features Layer (`lib/features/`)

Each feature follows the same structure:
```
feature_name/
├── bloc/
│   ├── feature_bloc.dart
│   ├── feature_event.dart
│   └── feature_state.dart
├── screens/
│   └── *.dart
└── widgets/
    └── *.dart
```

#### Authentication Feature (`lib/features/auth/`)
**Purpose**: User authentication and account management

**Bloc**:
- `auth_bloc.dart` - Authentication state management
- `auth_event.dart` - Auth events (sign in, sign up, sign out, reset password)
- `auth_state.dart` - Auth states (authenticated, unauthenticated, loading, error)

**Screens**:
- `login_screen.dart` - Email/password login
- `signup_screen.dart` - New user registration
- `forgot_password_screen.dart` - Password reset

#### Feed Feature (`lib/features/feed/`)
**Purpose**: Social feed for sharing observations

**Bloc**:
- `feed_bloc.dart` - Feed state management
- `feed_event.dart` - Feed events (load, refresh, like/unlike)
- `feed_state.dart` - Feed states (loading, loaded, error)

**Screens**:
- `feed_screen.dart` - Main feed displaying posts
- `create_post_screen.dart` - Create new post

**Widgets**:
- `post_card.dart` - Individual post display
- `post_image_viewer.dart` - Image gallery viewer

#### Events Feature (`lib/features/events/`)
**Purpose**: Astronomical events and community meetups

**Bloc**:
- `events_bloc.dart` - Events state management
- `events_event.dart` - Events operations
- `events_state.dart` - Events states

**Screens**:
- `events_screen.dart` - List of upcoming events
- `event_detail_screen.dart` - Detailed event view
- `create_event_screen.dart` - Create new event

**Widgets**:
- `event_card.dart` - Event list item

#### Groups Feature (`lib/features/groups/`)
**Purpose**: Community groups and clubs

**Bloc**:
- `groups_bloc.dart` - Groups state management
- `groups_event.dart` - Group operations
- `groups_state.dart` - Groups states

**Screens**:
- `groups_screen.dart` - Browse groups
- `group_detail_screen.dart` - Group details and members
- `create_group_screen.dart` - Create new group

**Widgets**:
- `group_card.dart` - Group list item

#### Chat Feature (`lib/features/chat/`)
**Purpose**: Real-time messaging

**Bloc**:
- `chat_bloc.dart` - Chat state management
- `chat_event.dart` - Chat operations
- `chat_state.dart` - Chat states

**Screens**:
- `conversations_screen.dart` - List of conversations
- `chat_screen.dart` - Individual chat view

**Widgets**:
- `message_bubble.dart` - Chat message bubble
- `chat_input.dart` - Message input field

#### Profile Feature (`lib/features/profile/`)
**Purpose**: User profiles and settings

**Bloc**:
- `profile_bloc.dart` - Profile state management
- `profile_event.dart` - Profile operations
- `profile_state.dart` - Profile states

**Screens**:
- `profile_screen.dart` - View user profile
- `edit_profile_screen.dart` - Edit profile information

**Widgets**:
- `profile_header.dart` - Profile header with avatar
- `equipment_list.dart` - User's astronomy equipment

### Shared Layer (`lib/shared/`)

#### Widgets (`lib/shared/widgets/`)
Reusable UI components:
- `custom_button.dart` - Styled button widget
- `custom_text_field.dart` - Styled text input
- `loading_indicator.dart` - Loading spinner
- `error_widget.dart` - Error display and empty states
- `bottom_nav_bar.dart` - Main navigation bar

#### Extensions (`lib/shared/extensions/`)
Dart extensions for convenience:
- `context_extensions.dart` - BuildContext utilities
- `string_extensions.dart` - String manipulation helpers

## Design Patterns

### State Management
- **BLoC Pattern**: All features use flutter_bloc for predictable state management
- **Repository Pattern**: Data layer separates business logic from data sources
- **Provider Pattern**: Dependency injection using RepositoryProvider

### Navigation
- **Declarative Routing**: Uses go_router for type-safe navigation
- **Deep Linking**: Ready for deep link support
- **Guard Routes**: Authentication-based route protection

### Architecture Layers

1. **Presentation Layer** (Screens & Widgets)
   - UI components and user interactions
   - Displays data from BLoC state
   - Dispatches events to BLoC

2. **Business Logic Layer** (BLoC)
   - Handles business logic
   - Manages application state
   - Coordinates between UI and data layers

3. **Data Layer** (Repositories & Models)
   - Data models with JSON serialization
   - Repository abstractions
   - Firebase operations

## Key Dependencies

- **flutter_bloc**: ^8.1.3 - State management
- **go_router**: ^12.1.1 - Navigation
- **firebase_core**: ^2.24.0 - Firebase initialization
- **cloud_firestore**: ^4.13.0 - Database
- **firebase_auth**: ^4.15.0 - Authentication
- **firebase_storage**: ^11.5.0 - File storage
- **geolocator**: ^10.1.0 - Location services
- **cached_network_image**: ^3.3.0 - Image caching
- **image_picker**: ^1.0.4 - Image selection
- **equatable**: ^2.0.5 - Value equality
- **intl**: ^0.18.1 - Internationalization
- **uuid**: ^4.2.1 - Unique ID generation

## Development Guidelines

### Adding a New Feature

1. Create feature directory: `lib/features/new_feature/`
2. Create BLoC files (bloc, event, state)
3. Create screen and widget files
4. Add routes in `lib/app/routes.dart`
5. Register repositories if needed
6. Write tests

### Code Style

- Follow Dart style guide
- Use the provided `analysis_options.yaml`
- Prefer const constructors
- Use trailing commas for better formatting
- Document public APIs

### Testing

- Unit tests for BLoC and repositories
- Widget tests for UI components
- Integration tests for user flows
- Run: `flutter test`

### Building

**Development**:
```bash
flutter run
```

**Production**:
```bash
flutter build apk --release    # Android
flutter build ios --release    # iOS
```

## Firebase Collections

The app uses the following Firestore collections:

- `users` - User profiles
- `posts` - Social feed posts
- `events` - Astronomical events and meetups
- `groups` - Community groups
- `conversations` - Chat conversations
  - `messages` - Sub-collection for messages
- `comments` - Post comments (sub-collection)
- `likes` - Post likes (sub-collection)

## Theme Configuration

The app uses a **dark theme** optimized for nighttime stargazing:

- **Primary**: Deep purple/indigo (#1a1a2e)
- **Accent**: Cosmic red (#e94560)
- **Background**: Near black (#0f0f1a)
- **Surface**: Dark grey (#16213e)
- **Text**: White with varying opacity for hierarchy

High contrast ensures readability in low-light conditions.

## Next Steps for Development

1. **Implement remaining features**:
   - Complete post creation with image upload
   - Implement event RSVP functionality
   - Add group join/leave logic
   - Complete real-time chat

2. **Add advanced features**:
   - Offline mode support
   - Push notifications
   - Weather integration
   - Sky map integration
   - AR constellation identification

3. **Performance optimization**:
   - Image optimization and caching
   - Lazy loading for lists
   - Pagination for large datasets

4. **Testing**:
   - Increase test coverage
   - Add integration tests
   - Test on multiple devices

5. **Deployment**:
   - Set up CI/CD
   - Configure app signing
   - Submit to app stores

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [BLoC Library](https://bloclibrary.dev/)
- [Go Router](https://pub.dev/packages/go_router)
- [Material Design 3](https://m3.material.io/)

---

**Last Updated**: December 2024
