import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';
import 'package:volt_nextgen/presentation/widgets/metric_card.dart';

class ActivitySummaryScreen extends StatelessWidget {
  final String distance;
  final String time;
  final String pace;
  final String heartRate;
  final SocialTier tier; // Would normally come from a provider

  const ActivitySummaryScreen({
    super.key,
    required this.distance,
    required this.time,
    required this.pace,
    required this.heartRate,
    this.tier = SocialTier.clan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo.shade500,
                  Colors.purple.shade800,
                ],
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // Celebration header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCelebrationHeader(context),
                  ),
                ),
                
                // Summary card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSummaryCard(context),
                  ),
                ),
                
                // Map preview
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildMapPreview(context),
                  ),
                ),
                
                // Stats details
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildStatsDetails(context),
                  ),
                ),
                
                // Action buttons
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildActionButtons(context),
                  ),
                ),
                
                // Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrationHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        
        Text(
          'Great Job!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 8.0),
        
        Text(
          'You\'ve completed your run',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        
        const SizedBox(height: 24.0),
        
        // Celebratory badge
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2.0,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.emoji_events,
              size: 40.0,
              color: Colors.amber,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return GlassmorphicCard(
      tier: tier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity type and date
          Row(
            children: [
              const Icon(
                Icons.directions_run,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 4.0),
              Text(
                'Morning Run',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                'May 16, 2025',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Key metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyMetric(context, 'Distance', distance, 'km'),
              _buildKeyMetric(context, 'Time', time, ''),
              _buildKeyMetric(context, 'Pace', pace, '/km'),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Achievements
          Row(
            children: [
              Text(
                'Achievements',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Fastest 1K',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'New Record',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetric(BuildContext context, String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        const SizedBox(height: 4.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMapPreview(BuildContext context) {
    // This would be a real map in the actual implementation
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.map,
                size: 48.0,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text(
                  'Route',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const Spacer(),
                const Icon(
                  Icons.location_on,
                  size: 16.0,
                  color: Colors.white70,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Central Park Loop',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsDetails(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Stats',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(context, 'Heart Rate', heartRate, 'bpm'),
              _buildStatItem(context, 'Cadence', '172', 'spm'),
              _buildStatItem(context, 'Elevation', '24', 'm'),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(context, 'Calories', '234', 'kcal'),
              _buildStatItem(context, 'Steps', '3,245', ''),
              _buildStatItem(context, 'Duration', time, ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 2.0),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Share button
        GlassmorphicButton(
          opacity: 0.7,
          blur: 10.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          onPressed: () {
            // Share activity
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.share,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Share with Community',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12.0),
        
        // Home button
        GlassmorphicButton(
          opacity: 0.5,
          blur: 8.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
              (route) => false,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Return to Dashboard',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
