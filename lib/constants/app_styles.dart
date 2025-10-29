import 'package:flutter/material.dart';

class AppStyles {
  // Light theme colors
  static const Color lightPrimaryColor = Colors.blue;
  static const Color lightSecondaryColor = Colors.green;
  static const Color lightBackgroundColor = Colors.white;
  static const Color lightSurfaceColor = Color(0xFFF5F5F5);
  static const Color lightTextColor = Colors.black87;
  static const Color lightSubtitleColor = Colors.grey;

  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFF2196F3);
  static const Color darkSecondaryColor = Color(0xFF4CAF50);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Colors.white;
  static const Color darkSubtitleColor = Colors.grey;

  // Common styles
  static const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const TextStyle subtitleStyle = TextStyle(fontSize: 18);
  static const TextStyle bodyStyle = TextStyle(fontSize: 16);
  static const TextStyle captionStyle = TextStyle(fontSize: 14);

  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;

  // Border radius
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}