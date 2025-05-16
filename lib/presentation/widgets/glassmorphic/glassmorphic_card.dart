import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/theme/app_colors.dart';

class GlassmorphicProperties {
  // Private constructor to prevent instantiation
  GlassmorphicProperties._();

  // Standard card properties
  static const double cardBorderRadius = 16.0;
  static const double cardBorderWidth = 1.5;

  // Button properties
  static const double buttonBorderRadius = 28.0;
  static const double buttonBorderWidth = 1.0;

  // Active/inactive state opacity adjustment
  static double getActiveOpacity(bool isActive) => isActive ? 0.7 : 0.5;

  // Gradient properties for enhanced depth
  static LinearGradient getLightGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(255, 255, 255, 0.7),
        Color.fromRGBO(255, 255, 255, 0.5),
      ],
    );
  }

  static LinearGradient getDarkGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(40, 40, 40, 0.7),
        Color.fromRGBO(20, 20, 20, 0.5),
      ],
    );
  }
}

class GlassmorphicColors {
  // Private constructor to prevent instantiation
  GlassmorphicColors._();

  // Translucent backgrounds with controlled opacity
  static const Color lightGlassBackground = Color.fromRGBO(255, 255, 255, 0.6);
  static const Color darkGlassBackground = Color.fromRGBO(30, 30, 30, 0.7);

  // Subtle borders to define glass edges
  static const Color lightGlassBorder = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color darkGlassBorder = Color.fromRGBO(255, 255, 255, 0.2);

  // Background blur settings
  static const double standardBlur = 10.0;
  static const double heavyBlur = 20.0;

  // Shadow properties for depth
  static const Color glassShadow = Color.fromRGBO(0, 0, 0, 0.1);

  // Overlay tints for tier-specific identity
  static Color getLightTierTint(SocialTier tier) {
    switch (tier) {
      case SocialTier.loneWolf:
        return AppColors.loneWolfColor.withValues(alpha: 0.08);
      case SocialTier.clan:
        return AppColors.clanColor.withValues(alpha: 0.1);
      case SocialTier.tribe:
        return AppColors.tribeColor.withValues(alpha: 0.12);
      case SocialTier.chiefdom:
        return AppColors.chiefdomColor.withValues(alpha: 0.15);
      case SocialTier.state:
        return AppColors.stateColor.withValues(alpha: 0.12);
      case SocialTier.nation:
        return AppColors.nationColor.withValues(alpha: 0.15);
    }
  }

  // Darker versions for dark mode tints
  static Color getDarkTierTint(SocialTier tier) {
    switch (tier) {
      case SocialTier.loneWolf:
        return AppColors.loneWolfColor.withValues(alpha: 0.2);
      case SocialTier.clan:
        return AppColors.clanColor.withValues(alpha: 0.2);
      case SocialTier.tribe:
        return AppColors.tribeColor.withValues(alpha: 0.25);
      case SocialTier.chiefdom:
        return AppColors.chiefdomColor.withValues(alpha: 0.3);
      case SocialTier.state:
        return AppColors.stateColor.withValues(alpha: 0.25);
      case SocialTier.nation:
        return AppColors.nationColor.withValues(alpha: 0.3);
    }
  }
}

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final Color? tintColor;
  final BorderRadius borderRadius;
  final bool hasBorder;
  final SocialTier? tier;
  final EdgeInsetsGeometry padding;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.opacity = 0.6,
    this.blur = 10.0,
    this.tintColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.hasBorder = true,
    this.tier,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDarkMode
            ? GlassmorphicColors.darkGlassBorder
            : GlassmorphicColors.lightGlassBorder;

    // Apply tier tint if specified
    final effectiveTintColor =
        tier != null
            ? (isDarkMode
                ? GlassmorphicColors.getDarkTierTint(tier!)
                : GlassmorphicColors.getLightTierTint(tier!))
            : tintColor;

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: (isDarkMode
                    ? GlassmorphicColors.darkGlassBackground
                    : GlassmorphicColors.lightGlassBackground)
                .withValues(alpha: opacity),
            borderRadius: borderRadius,
            border:
                hasBorder
                    ? Border.all(
                      color: borderColor,
                      width: GlassmorphicProperties.cardBorderWidth,
                    )
                    : null,
            gradient:
                isDarkMode
                    ? GlassmorphicProperties.getDarkGradient()
                    : GlassmorphicProperties.getLightGradient(),
          ),
          child: Container(
            // Apply a subtle tint overlay if applicable
            decoration: BoxDecoration(
              color: effectiveTintColor,
              borderRadius: borderRadius,
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
