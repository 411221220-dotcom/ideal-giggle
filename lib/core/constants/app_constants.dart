/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Stargazing Social';
  static const String appVersion = '1.0.0';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String postsCollection = 'posts';
  static const String eventsCollection = 'events';
  static const String groupsCollection = 'groups';
  static const String messagesCollection = 'messages';
  static const String conversationsCollection = 'conversations';
  static const String commentsCollection = 'comments';
  static const String likesCollection = 'likes';
  
  // Storage Paths
  static const String profilePicturesPath = 'profile_pictures';
  static const String postImagesPath = 'post_images';
  static const String eventImagesPath = 'event_images';
  static const String groupImagesPath = 'group_images';
  
  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // Pagination
  static const int postsPerPage = 10;
  static const int eventsPerPage = 20;
  static const int groupsPerPage = 15;
  static const int messagesPerPage = 50;
  
  // Image Constraints
  static const int maxImageSizeInBytes = 5 * 1024 * 1024; // 5MB
  static const double imageQuality = 0.8;
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxBioLength = 500;
  static const int maxPostTextLength = 2000;
  static const int maxEventDescriptionLength = 1000;
  static const int maxGroupDescriptionLength = 500;
  
  // Astronomy Interests
  static const List<String> astronomyInterests = [
    'Planets',
    'Deep Sky Objects',
    'Astrophotography',
    'Meteor Showers',
    'Eclipses',
    'Moon Observation',
    'Comets',
    'Satellites',
    'ISS Tracking',
    'Star Parties',
    'Nebulae',
    'Galaxies',
    'Star Clusters',
    'Double Stars',
    'Variable Stars',
  ];
  
  // Equipment Categories
  static const List<String> equipmentCategories = [
    'Telescope',
    'Binoculars',
    'Camera',
    'Mount',
    'Eyepiece',
    'Filter',
    'Finder Scope',
    'Barlow Lens',
    'Star Tracker',
    'Red Light',
  ];
  
  // Event Types
  static const List<String> eventTypes = [
    'Meteor Shower',
    'Eclipse',
    'ISS Pass',
    'Planetary Alignment',
    'Star Party',
    'Club Meeting',
    'Astrophotography Session',
    'Public Observation',
    'Workshop',
    'Other',
  ];
  
  // Time Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy • hh:mm a';
  
  // Error Messages
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication error. Please sign in again.';
  static const String permissionError = 'Permission denied. Please check app permissions.';
}
