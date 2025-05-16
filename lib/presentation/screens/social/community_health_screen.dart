import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class CommunityHealthScreen extends StatefulWidget {
  const CommunityHealthScreen({super.key});

  @override
  State<CommunityHealthScreen> createState() => _CommunityHealthScreenState();
}

class _CommunityHealthScreenState extends State<CommunityHealthScreen> {
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider
  int _selectedTabIndex = 0;
  
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
                  Colors.purple.shade700,
                  Colors.indigo.shade800,
                ],
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App bar
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  title: Text(
                    'Community Health',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.help_outline, color: Colors.white),
                      onPressed: () {
                        // Show help
                      },
                    ),
                  ],
                ),
                
                // Health status
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildHealthStatus(context),
                  ),
                ),
                
                // Tab selector
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTabSelector(context),
                  ),
                ),
                
                // Tab content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildTabContent(context),
                  ),
                ),
                
                // Action items
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildActionItems(context),
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

  Widget _buildHealthStatus(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        children: [
          // Status indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16.0,
                height: 16.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                'Excellent Health',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Health meters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHealthMeter(context, 'Activity', 0.85),
              _buildHealthMeter(context, 'Growth', 0.62),
              _buildHealthMeter(context, 'Engagement', 0.71),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Status description
          Text(
            'Your community is thriving with regular activities and good engagement. Keep building momentum towards the Tribe tier!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMeter(BuildContext context, String label, double value) {
    // Determine color based on value
    Color meterColor;
    if (value >= 0.7) {
      meterColor = Colors.green;
    } else if (value >= 0.4) {
      meterColor = Colors.orange;
    } else {
      meterColor = Colors.red;
    }
    
    return Column(
      children: [
        // Circular progress
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: Stack(
            children: [
              // Background
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              
              // Progress
              Positioned.fill(
                child: CircularProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(meterColor),
                  strokeWidth: 8.0,
                ),
              ),
              
              // Percentage text
              Center(
                child: Text(
                  '${(value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 8.0),
        
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget _buildTabSelector(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Activity Metrics',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: _selectedTabIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Member Analysis',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: _selectedTabIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    if (_selectedTabIndex == 0) {
      return _buildActivityMetricsTab(context);
    } else {
      return _buildMemberAnalysisTab(context);
    }
  }

  Widget _buildActivityMetricsTab(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Activity Trends',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Chart placeholder
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48.0,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Activity Trend Chart',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Activity stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActivityStat(context, 'This Week', '32', '+15%'),
              _buildActivityStat(context, 'Last Week', '28', '+40%'),
              _buildActivityStat(context, 'Average', '18', ''),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Activity breakdown
          Text(
            'Activity Breakdown',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          // Activity types (simplified pie chart)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 16.0,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 16.0,
                  color: Colors.green,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 16.0,
                  color: Colors.orange,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 16.0,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8.0),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(context, 'Run', Colors.blue, '65%'),
              _buildLegendItem(context, 'Walk', Colors.green, '20%'),
              _buildLegendItem(context, 'Bike', Colors.orange, '10%'),
              _buildLegendItem(context, 'Other', Colors.purple, '5%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStat(BuildContext context, String label, String value, String change) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        if (change.isNotEmpty)
          Text(
            change,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color, String percentage) {
    return Row(
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '$label ($percentage)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget _buildMemberAnalysisTab(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Member Activity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Member grid (simplified)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            children: [
              _buildMemberCell(context, 'S', 'High', Colors.green),
              _buildMemberCell(context, 'J', 'High', Colors.green),
              _buildMemberCell(context, 'E', 'Medium', Colors.orange),
              _buildMemberCell(context, 'M', 'Medium', Colors.orange),
              _buildMemberCell(context, 'A', 'Medium', Colors.orange),
              _buildMemberCell(context, 'L', 'Low', Colors.red),
              _buildMemberCell(context, 'C', 'Low', Colors.red),
              _buildMemberCell(context, 'R', 'High', Colors.green),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Activity distribution
          Text(
            'Activity Distribution',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          // Activity bars
          Column(
            children: [
              _buildActivityBar(context, 'High Activity', 0.375, Colors.green),
              const SizedBox(height: 8.0),
              _buildActivityBar(context, 'Medium Activity', 0.375, Colors.orange),
              const SizedBox(height: 8.0),
              _buildActivityBar(context, 'Low Activity', 0.25, Colors.red),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Retention info
          Text(
            'Member Retention: Excellent',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          Text(
            'Your community has 100% retention over the past 30 days. No members have left the group.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCell(BuildContext context, String initial, String activity, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                initial,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            activity,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(BuildContext context, String label, double value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // Background
              Container(
                height: 16.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              
              // Progress
              Container(
                height: 16.0,
                width: MediaQuery.of(context).size.width * value * 0.5, // Approximate width
                decoration: BoxDecoration(
                  color: color.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          '${(value * 100).toInt()}%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildActionItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        GlassmorphicCard(
          opacity: 0.4,
          blur: 8.0,
          child: Column(
            children: [
              _buildActionItem(
                context,
                'Engagement Boost',
                'Create a weekend challenge to increase member participation',
                Icons.emoji_events,
                Colors.amber,
              ),
              const Divider(color: Colors.white24),
              _buildActionItem(
                context,
                'Growth Opportunity',
                'Invite 2 more members to reach the required 10 for Tribe tier',
                Icons.group_add,
                Colors.blue,
              ),
              const Divider(color: Colors.white24),
              _buildActionItem(
                context,
                'Activity Goal',
                'Encourage members to log 44 more km to reach the 200 km tier requirement',
                Icons.directions_run,
                Colors.green,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24.0),
        
        // Generate report button
        GlassmorphicButton(
          opacity: 0.6,
          blur: 8.0,
          onPressed: () {
            // Generate report
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.summarize,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Generate Health Report',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
