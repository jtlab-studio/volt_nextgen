import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final Color? tintColor;
  final BorderRadius borderRadius;
  final bool hasBorder;
  final SocialTier? tier;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final BoxShape shape;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.opacity = 0.6,
    this.blur = 10.0,
    this.tintColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.hasBorder = true,
    this.tier,
    this.padding = const EdgeInsets.all(16.0),
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode
        ? GlassmorphicColors.darkGlassBorder
        : GlassmorphicColors.lightGlassBorder;

    // Apply tier tint if specified
    final effectiveTintColor = tier != null
        ? (isDarkMode
            ? GlassmorphicColors.getDarkTierTint(tier!)
            : GlassmorphicColors.getLightTierTint(tier!))
        : tintColor;

    if (shape == BoxShape.circle) {
      return SizedBox(
        width: width,
        height: height,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                color: (isDarkMode
                        ? GlassmorphicColors.darkGlassBackground
                        : GlassmorphicColors.lightGlassBackground)
                    .withOpacity(opacity),
                shape: BoxShape.circle,
                border: hasBorder
                    ? Border.all(
                        color: borderColor,
                        width: GlassmorphicProperties.cardBorderWidth,
                      )
                    : null,
                gradient: isDarkMode
                    ? GlassmorphicProperties.getDarkGradient()
                    : GlassmorphicProperties.getLightGradient(),
              ),
              child: Container(
                // Apply a subtle tint overlay if applicable
                decoration: BoxDecoration(
                  color: effectiveTintColor,
                  shape: BoxShape.circle,
                ),
                padding: padding,
                child: Center(child: child),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                color: (isDarkMode
                        ? GlassmorphicColors.darkGlassBackground
                        : GlassmorphicColors.lightGlassBackground)
                    .withOpacity(opacity),
                borderRadius: borderRadius,
                border: hasBorder
                    ? Border.all(
                        color: borderColor,
                        width: GlassmorphicProperties.cardBorderWidth,
                      )
                    : null,
                gradient: isDarkMode
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
        ),
      );
    }
  }
}
