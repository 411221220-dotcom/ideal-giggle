import 'package:flutter/material.dart';

/// Color palette optimized for nighttime stargazing
/// Deep space-inspired colors with high contrast for low-light readability
class AppColors {
  AppColors._();

  // Primary Colors - Deep purple/indigo
  static const Color primaryDark = Color(0xFF1a1a2e);
  static const Color primaryLight = Color(0xFF2d2d44);
  
  // Accent Colors - Cosmic red
  static const Color accentRed = Color(0xFFe94560);
  static const Color accentRedLight = Color(0xFFff6b6b);
  
  // Alternative Accent - Star gold (for highlights)
  static const Color starGold = Color(0xFFffd700);
  static const Color starGoldLight = Color(0xFFffe55c);
  
  // Background Colors - Near black
  static const Color backgroundDark = Color(0xFF0f0f1a);
  static const Color backgroundMedium = Color(0xFF16213e);
  
  // Surface Colors
  static const Color surfaceDark = Color(0xFF16213e);
  static const Color surfaceLight = Color(0xFF1f2d4d);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFFb0b0b0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Semantic Colors
  static const Color success = Color(0xFF4caf50);
  static const Color warning = Color(0xFFff9800);
  static const Color error = Color(0xFFf44336);
  static const Color info = Color(0xFF2196f3);
  
  // Divider and Border
  static const Color divider = Color(0xFF2d2d44);
  static const Color border = Color(0xFF3d3d5c);
  
  // Card and Container
  static const Color cardBackground = Color(0xFF1a1a2e);
  static const Color containerBackground = Color(0xFF16213e);
  
  // Shimmer effect colors for loading
  static const Color shimmerBase = Color(0xFF1a1a2e);
  static const Color shimmerHighlight = Color(0xFF2d2d44);
  
  // Gradient colors for special UI elements
  static const LinearGradient cosmicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1a1a2e),
      Color(0xFF16213e),
      Color(0xFF0f0f1a),
    ],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFe94560),
      Color(0xFFff6b6b),
    ],
  );
}
