/// Extensions for String
extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Check if string is empty or only contains whitespace
  bool get isBlank => trim().isEmpty;

  /// Check if string is not empty and not only whitespace
  bool get isNotBlank => !isBlank;

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Convert string to title case
  String toTitleCase() {
    return toLowerCase().capitalizeWords();
  }

  /// Remove special characters
  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  /// Get initials from name
  String get initials {
    if (isEmpty) return '';
    final parts = trim().split(' ');
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return parts[0].substring(0, 1).toUpperCase() +
        parts[parts.length - 1].substring(0, 1).toUpperCase();
  }
}

/// Extensions for nullable String
extension NullableStringExtensions on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Check if string is null or blank (empty or whitespace)
  bool get isNullOrBlank => this == null || this!.isBlank;

  /// Check if string is not null and not blank
  bool get isNotNullOrBlank => !isNullOrBlank;

  /// Get string or default value if null
  String orDefault(String defaultValue) => this ?? defaultValue;

  /// Get string or empty string if null
  String get orEmpty => this ?? '';
}
