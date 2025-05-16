import 'package:flutter/material.dart';
import 'package:volt_nextgen/presentation/screens/activity_history/activity_detail_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class ActivityCard extends StatelessWidget {
  final String date;
  final String type;
  final String distance;
  final String time;
  final String pace;
  final String? elevation;
  final String? heartRate;

  const ActivityCard({
    super.key,
    required this.date,
    required this.type,
    required this.distance,
    required this.time,
    required this.pace,
    this.elevation,
    this.heartRate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 10.0,
        borderRadius: BorderRadius.circular(12.0),
        padding: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ActivityDetailScreen(
                      type: type,
                      date: date,
                      distance: distance,
                      time: time,
                      pace: pace,
                    ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Map thumbnail (placeholder)
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.map,
                      color: Colors.white.withValues(alpha: 0.4),
                      size: 32.0,
                    ),
                  ),
                ),

                // Activity details
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          _buildMetric(context, Icons.straighten, distance),
                          const SizedBox(width: 12.0),
                          _buildMetric(context, Icons.timer, time),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          _buildMetric(context, Icons.speed, pace),
                          if (heartRate != null) ...[
                            const SizedBox(width: 12.0),
                            _buildMetric(context, Icons.favorite, heartRate!),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 14.0),
        const SizedBox(width: 4.0),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
