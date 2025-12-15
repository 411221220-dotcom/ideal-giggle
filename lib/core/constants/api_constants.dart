/// API and external service constants
class ApiConstants {
  ApiConstants._();

  // Base URLs (Configure these based on your backend)
  static const String baseUrl = 'https://api.stargazingsocial.com';
  static const String apiVersion = 'v1';
  
  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  
  // External APIs (Optional integrations)
  
  // NASA API (for astronomical events)
  static const String nasaApiKey = 'DEMO_KEY'; // Replace with actual key
  static const String nasaBaseUrl = 'https://api.nasa.gov';
  
  // Weather API (for observing conditions)
  static const String weatherApiKey = ''; // Configure if using weather service
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Astronomy API (for sky data)
  static const String astronomyApiKey = ''; // Configure if using astronomy service
  
  // ISS Tracking
  static const String issTrackingUrl = 'http://api.open-notify.org/iss-now.json';
  
  // Endpoints (if using custom backend)
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String postsEndpoint = '/posts';
  static const String eventsEndpoint = '/events';
  static const String groupsEndpoint = '/groups';
  static const String usersEndpoint = '/users';
}
