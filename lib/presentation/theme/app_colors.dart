import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary colors
  static const Color primaryColor = Color(0xFF5E17EB);
  static const Color secondaryColor = Color(0xFF30D158);
  static const Color accentColor = Color(0xFFFF9500);

  // Background colors
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color darkBackground = Color(0xFF1E1E1E);

  // Tier-specific colors
  static const Color loneWolfColor = Color(0xFF808080); // Gray
  static const Color clanColor = Color(0xFF5E17EB);     // Purple
  static const Color tribeColor = Color(0xFF30D158);    // Green
  static const Color chiefdomColor = Color(0xFFFF9500); // Orange
  static const Color stateColor = Color(0xFF0A84FF);    // Blue
  static const Color nationColor = Color(0xFFFF2D55);   // Red

  // Get color by tier
  static Color getColorForTier(SocialTier tier) {
    switch (tier) {
      case SocialTier.loneWolf:
        return loneWolfColor;
      case SocialTier.clan:
        return clanColor;
      case SocialTier.tribe:
        return tribeColor;
      case SocialTier.chiefdom:
        return chiefdomColor;
      case SocialTier.state:
        return stateColor;
      case SocialTier.nation:
        return nationColor;
      default:
        return loneWolfColor;
    }
  }

  // Text colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textTertiary = Color(0xFFA8A8AA);
  
  // Text colors for dark mode
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFBBBBBB);
  static const Color darkTextTertiary = Color(0xFF8E8E93);
  
  // Functional colors
  static const Color success = Color(0xFF30D158);
  static const Color warning = Color(0xFFFFD60A);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF0A84FF);
}
