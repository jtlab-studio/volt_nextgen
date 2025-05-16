import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';
import 'package:volt_nextgen/presentation/widgets/metric_card.dart';

class ActivityDetailScreen extends StatefulWidget {
  final String type;
  final String date;
  final String distance;
  final String time;
  final String pace;

  const ActivityDetailScreen({
    super.key,
    required this.type,
    required this.date,
    required this.distance,
    required this.time,
    required this.pace,
  });

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  int _selectedTabIndex = 0;
  final SocialTier _userTier =
      SocialTier.clan; // Would normally come from a provider

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
                colors: [Colors.blue.shade600, Colors.indigo.shade800],
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
                  floating: true,
                  title: Text(
                    widget.type,
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
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Share activity
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {
                        // Open menu
                      },
                    ),
                  ],
                ),

                // Map and key metrics
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildMapAndKeyMetrics(context),
                  ),
                ),

                // Tabs
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTabs(context),
                  ),
                ),

                // Tab content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildTabContent(context),
                  ),
                ),

                // Social section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSocialSection(context),
                  ),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapAndKeyMetrics(BuildContext context) {
    return Column(
      children: [
        // Map preview
        GlassmorphicCard(
          opacity: 0.5,
          blur: 10.0,
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.map,
                    size: 48.0,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'Route',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.white),
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16.0),

        // Key metrics
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Distance',
                value: widget.distance,
                unit: 'km',
                icon: Icons.straighten,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: MetricCard(
                label: 'Time',
                value: widget.time,
                icon: Icons.timer,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: MetricCard(
                label: 'Pace',
                value: widget.pace,
                unit: '/km',
                icon: Icons.speed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabs(BuildContext context) {
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
                  color:
                      _selectedTabIndex == 0
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Stats',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight:
                          _selectedTabIndex == 0
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
                  color:
                      _selectedTabIndex == 1
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Splits',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight:
                          _selectedTabIndex == 1
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
                  _selectedTabIndex = 2;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color:
                      _selectedTabIndex == 2
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Charts',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight:
                          _selectedTabIndex == 2
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
      return _buildStatsTab(context);
    } else if (_selectedTabIndex == 1) {
      return _buildSplitsTab(context);
    } else {
      return _buildChartsTab(context);
    }
  }

  Widget _buildStatsTab(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Statistics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          _buildStatRow(context, 'Avg. Heart Rate', '148', 'bpm'),
          _buildDivider(),
          _buildStatRow(context, 'Max Heart Rate', '172', 'bpm'),
          _buildDivider(),
          _buildStatRow(context, 'Avg. Cadence', '172', 'spm'),
          _buildDivider(),
          _buildStatRow(context, 'Elevation Gain', '24', 'm'),
          _buildDivider(),
          _buildStatRow(context, 'Calories', '234', 'kcal'),
          _buildDivider(),
          _buildStatRow(context, 'Avg. Stride Length', '1.08', 'm'),

          const SizedBox(height: 16.0),

          // Heart rate zones (simplified)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Heart Rate Zones',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),

              const SizedBox(height: 8.0),

              SizedBox(
                height: 24.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300.withValues(alpha: 0.8),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Container(
                        color: Colors.green.shade400.withValues(alpha: 0.8),
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Container(
                        color: Colors.yellow.shade600.withValues(alpha: 0.8),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        color: Colors.orange.shade600.withValues(alpha: 0.8),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade400.withValues(alpha: 0.8),
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Easy',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    'Moderate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    'Hard',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    String unit,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2.0),
              Text(
                unit,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1.0, color: Colors.white.withValues(alpha: 0.1));
  }

  Widget _buildSplitsTab(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Split Times',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Table header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'KM',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Split',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Pace',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'HR',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),
          _buildDivider(),
          const SizedBox(height: 8.0),

          // Split rows
          _buildSplitRow(context, '1', '05:21', '5:21', '145', isFastest: true),
          _buildDivider(),
          _buildSplitRow(context, '2', '05:32', '5:32', '148'),
          _buildDivider(),
          _buildSplitRow(context, '3', '05:25', '5:25', '152'),
          _buildDivider(),
          _buildSplitRow(context, '4', '05:38', '5:38', '146'),
          _buildDivider(),
          _buildSplitRow(context, '5', '05:29', '5:29', '150'),

          const SizedBox(height: 12.0),

          // Legend
          Row(
            children: [
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Colors.green.shade400.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 4.0),
              Text(
                'Fastest Split',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 12.0),
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Colors.red.shade400.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 4.0),
              Text(
                'Slowest Split',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSplitRow(
    BuildContext context,
    String km,
    String split,
    String pace,
    String hr, {
    bool isFastest = false,
    bool isSlowest = false,
  }) {
    Color? rowColor;
    if (isFastest) {
      rowColor = Colors.green.shade400.withValues(alpha: 0.2);
    } else if (isSlowest) {
      rowColor = Colors.red.shade400.withValues(alpha: 0.2);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              km,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              split,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              pace,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              hr,
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsTab(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Charts',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Chart selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildChartTypeButton(context, 'Pace', true),
              _buildChartTypeButton(context, 'Heart Rate', false),
              _buildChartTypeButton(context, 'Elevation', false),
            ],
          ),

          const SizedBox(height: 24.0),

          // Placeholder for chart
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48.0,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Pace Chart',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16.0),

          // Stats under chart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChartStat(context, 'Avg', '5:29/km'),
              _buildChartStat(context, 'Max', '5:21/km'),
              _buildChartStat(context, 'Min', '5:38/km'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        // Switch chart
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildChartStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Likes
          Row(
            children: [
              const Icon(Icons.favorite, size: 18.0, color: Colors.pinkAccent),
              const SizedBox(width: 8.0),
              Text(
                '12 likes',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
                onPressed: () {
                  // Like activity
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Like',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Comments
          Text(
            'Comments',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 8.0),

          // Comment list
          _buildCommentItem(
            context,
            'Sarah',
            'Great pace! Keep it up!',
            '10 min ago',
          ),
          const SizedBox(height: 8.0),
          _buildCommentItem(
            context,
            'Mike',
            'Nice job on the hill segment.',
            '1 hour ago',
          ),

          const SizedBox(height: 16.0),

          // Add comment
          Row(
            children: [
              Expanded(
                child: GlassmorphicCard(
                  opacity: 0.3,
                  blur: 5.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 0.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                padding: const EdgeInsets.all(10.0),
                isCircular: true,
                height: 40.0,
                width: 40.0,
                onPressed: () {
                  // Send comment
                },
                child: const Icon(Icons.send, size: 18.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(
    BuildContext context,
    String name,
    String comment,
    String timeAgo,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          child: Center(
            child: Text(
              name[0],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8.0),

        // Comment content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    timeAgo,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              Text(
                comment,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
