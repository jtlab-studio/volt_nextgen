import 'package:flutter/material.dart';
import 'package:volt_nextgen/presentation/screens/activity_history/activity_detail_screen.dart';
import 'package:volt_nextgen/presentation/widgets/activity_card.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  final List<String> _filterOptions = ['All', 'Run', 'Walk', 'Bike', 'Hike'];
  String _selectedFilter = 'All';

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
                    'Activity History',
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
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // Open search
                      },
                    ),
                  ],
                ),

                // Filter section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildFilterSection(context),
                  ),
                ),

                // Activity timeline
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTimelineHeader(context, 'This Week'),
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    _buildActivityItem(
                      context,
                      'Morning Run',
                      'Today',
                      '5.2 km',
                      '28:45',
                      '5:31/km',
                    ),
                    _buildActivityItem(
                      context,
                      'Interval Training',
                      'Yesterday',
                      '3.8 km',
                      '22:15',
                      '5:51/km',
                    ),
                    _buildActivityItem(
                      context,
                      'Long Run',
                      'May 14',
                      '8.1 km',
                      '47:30',
                      '5:52/km',
                    ),
                  ]),
                ),

                // Previous week
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTimelineHeader(context, 'Last Week'),
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    _buildActivityItem(
                      context,
                      'Recovery Run',
                      'May 11',
                      '4.5 km',
                      '25:12',
                      '5:36/km',
                    ),
                    _buildActivityItem(
                      context,
                      'Tempo Run',
                      'May 9',
                      '6.2 km',
                      '32:45',
                      '5:17/km',
                    ),
                    _buildActivityItem(
                      context,
                      'Easy Run',
                      'May 7',
                      '5.5 km',
                      '31:22',
                      '5:42/km',
                    ),
                  ]),
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

  Widget _buildFilterSection(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.6,
      blur: 10.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          // Activity type filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _filterOptions.map((filter) {
                    final isSelected = filter == _selectedFilter;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          }
                        },
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        selectedColor: Colors.white.withValues(alpha: 0.4),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          const SizedBox(height: 12.0),

          // Advanced filters
          Row(
            children: [
              // Date range
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Open date picker
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Last 30 Days',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8.0),

              // Sort by
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Open sort options
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sort, size: 16.0, color: Colors.white),
                        const SizedBox(width: 4.0),
                        Text(
                          'Date (Newest)',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              height: 1.0,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String type,
    String date,
    String distance,
    String time,
    String pace,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 8.0,
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
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Activity icon
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: const Icon(Icons.directions_run, color: Colors.white),
                ),

                const SizedBox(width: 16.0),

                // Activity details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            date,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8.0),

                      Row(
                        children: [
                          _buildMetricPill(context, Icons.straighten, distance),
                          const SizedBox(width: 8.0),
                          _buildMetricPill(context, Icons.timer, time),
                          const SizedBox(width: 8.0),
                          _buildMetricPill(context, Icons.speed, pace),
                        ],
                      ),
                    ],
                  ),
                ),

                // Chevron
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricPill(BuildContext context, IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12.0, color: Colors.white),
          const SizedBox(width: 4.0),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
