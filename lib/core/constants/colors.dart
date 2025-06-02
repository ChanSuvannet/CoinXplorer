import 'package:flutter/material.dart';

/// A centralized class to manage all app-wide color constants.
/// Inspired by CoinMarketCap's theme with a focus on dark mode UI and clean visual hierarchy.
class AppColors {
  
  // === Brand Colors ===
  /// Primary accent color (e.g., used to indicate positive trends or success).
  static const Color primary = Color(0xFF00C853); // Bright green

  /// Secondary accent color (e.g., used to indicate negative trends or errors).
  static const Color secondary = Color(0xFFD32F2F); // Bright red

  // === Background Colors ===
  /// Default dark mode background.
  static const Color backgroundDark = Color.fromARGB(255, 42, 42, 42);

  /// Default light mode background.
  static const Color backgroundLight = Colors.white;

  /// Card background color used in dark mode containers.
  static const Color cardDark = Color(0xFF1E1E1E);

  // === Text Colors ===
  /// Primary text color on dark backgrounds (high emphasis).
  static const Color textPrimary = Color(0xFFE0E0E0);

  /// Secondary text color on dark backgrounds (medium emphasis).
  static const Color textSecondary = Color(0xFFB0B0B0);

  static const Color textTertiary = Color(0xFF888888);

  /// Text color on light backgrounds (e.g., cards in light theme).
  static const Color textDark = Colors.black87;

  // === Border and Divider ===
  /// Divider or card border color in dark mode.
  static const Color border = Color(0xFF333333);

  /// Light gray used for borders or subtle UI elements in light theme.
  static const Color borderLight = Color(0xFFEEEEEE);

  // === Status Colors ===
  /// Used for info banners or tags.
  static const Color info = Color(0xFF1976D2);

  /// Used for warning states.
  static const Color warning = Color(0xFFFFA000);

  /// Used for neutral or disabled UI elements.
  static const Color disabled = Color(0xFF9E9E9E);
  
}
