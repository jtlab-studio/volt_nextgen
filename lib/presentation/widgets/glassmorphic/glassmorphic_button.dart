import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class GlassmorphicButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double opacity;
  final double blur;
  final BorderRadius borderRadius;
  final SocialTier? tier;
  final bool hasBorder;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final bool isCircular;
  final double? height;
  final double? width;

  const GlassmorphicButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.opacity = 0.7,
    this.blur = 8.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    this.tier,
    this.hasBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.elevation = 0,
    this.isCircular = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode
        ? GlassmorphicColors.darkGlassBorder
        : GlassmorphicColors.lightGlassBorder;

    final effectiveTintColor = tier != null
        ? (isDarkMode
            ? GlassmorphicColors.getDarkTierTint(tier!)
            : GlassmorphicColors.getLightTierTint(tier!))
        : null;

    final effectiveBorderRadius = isCircular
        ? BorderRadius.circular(height != null ? height! / 2 : 100)
        : borderRadius;

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: effectiveBorderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: effectiveBorderRadius,
        splashColor: effectiveTintColor?.withOpacity(0.3) ??
            Colors.white.withOpacity(0.3),
        highlightColor: effectiveTintColor?.withOpacity(0.2) ??
            Colors.white.withOpacity(0.1),
        child: ClipRRect(
          borderRadius: effectiveBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              height: height,
              width: width ?? (isCircular ? height : null),
              padding: padding,
              decoration: BoxDecoration(
                color: (isDarkMode
                        ? GlassmorphicColors.darkGlassBackground
                        : GlassmorphicColors.lightGlassBackground)
                    .withOpacity(opacity),
                borderRadius: effectiveBorderRadius,
                border: hasBorder
                    ? Border.all(
                        color: borderColor,
                        width: GlassmorphicProperties.buttonBorderWidth,
                      )
                    : null,
                gradient: isDarkMode
                    ? GlassmorphicProperties.getDarkGradient()
                    : GlassmorphicProperties.getLightGradient(),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
