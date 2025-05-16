import 'package:flutter/material.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color? color;
  final bool isLarge;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.65,
      blur: 8.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: EdgeInsets.all(isLarge ? 16.0 : 12.0),
      child: SizedBox(
        width: isLarge ? null : 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: color ?? Colors.white.withValues(alpha: 0.8),
                    size: 14.0,
                  ),
                  const SizedBox(width: 4.0),
                ],
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            // Value
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isLarge ? 28.0 : 20.0,
                    fontFamily: 'monospace',
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 2.0),
                  Text(
                    unit!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
