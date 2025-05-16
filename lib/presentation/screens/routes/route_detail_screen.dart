import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/activity_history/activity_history_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class RouteDetailScreen extends StatefulWidget {
  final String routeName;
  final String distance;
  final String difficulty;

  const RouteDetailScreen({
    super.key,
    required this.routeName,
    required this.distance,
    required this.difficulty,
  });

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final SocialTier _userTier =
      SocialTier.clan; // Would normally come from a provider
  bool _isFavorite = false;

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
                colors: [Colors.green.shade800, Colors.blue.shade900],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App bar with transparency
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  title: Text(
                    widget.routeName,
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
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Share route
                      },
                    ),
                  ],
                ),

                // Map visualization
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildMapVisualization(context),
                  ),
                ),

                // Route information
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildRouteInformation(context),
                  ),
                ),

                // Social context
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSocialContext(context),
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
                const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapVisualization(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.5,
      blur: 10.0,
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          // Map container
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.white.withValues(alpha: 0.1),
              child: Stack(
                children: [
                  // Map placeholder
                  Center(
                    child: Icon(
                      Icons.map,
                      size: 48.0,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),

                  // Start/end markers
                  Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70.0,
                    right: 60.0,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  ),

                  // Map controls
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Column(
                      children: [
                        _buildMapControlButton(context, Icons.add, () {
                          // Zoom in
                        }),
                        const SizedBox(height: 4.0),
                        _buildMapControlButton(context, Icons.remove, () {
                          // Zoom out
                        }),
                        const SizedBox(height: 4.0),
                        _buildMapControlButton(context, Icons.my_location, () {
                          // Show current location
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Elevation profile
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Elevation Profile',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),

                const SizedBox(height: 8.0),

                // Elevation chart placeholder
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.area_chart,
                      size: 32.0,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),

                const SizedBox(height: 8.0),

                // Elevation stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildElevationStat(context, 'Gain', '+120m'),
                    _buildElevationStat(context, 'Loss', '-85m'),
                    _buildElevationStat(context, 'Min', '23m'),
                    _buildElevationStat(context, 'Max', '143m'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.0),
      ),
    );
  }

  Widget _buildElevationStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
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

  Widget _buildRouteInformation(BuildContext context) {
    Color difficultyColor;
    switch (widget.difficulty) {
      case 'Easy':
        difficultyColor = Colors.green;
        break;
      case 'Moderate':
        difficultyColor = Colors.orange;
        break;
      case 'Hard':
        difficultyColor = Colors.red;
        break;
      default:
        difficultyColor = Colors.green;
    }

    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Stats dashboard
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRouteStat(
                context,
                'Distance',
                widget.distance,
                Icons.straighten,
              ),
              _buildRouteStat(context, 'Est. Time', '28 min', Icons.timer),
              _buildRouteStat(
                context,
                'Difficulty',
                widget.difficulty,
                Icons.trending_up,
                valueColor: difficultyColor,
              ),
            ],
          ),

          const Divider(color: Colors.white24, height: 32.0),

          // Additional info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      context,
                      'Surface Type',
                      'Asphalt (80%), Trail (20%)',
                    ),
                    const SizedBox(height: 8.0),
                    _buildInfoRow(context, 'Traffic', 'Light'),
                    const SizedBox(height: 8.0),
                    _buildInfoRow(context, 'Safety Rating', 'High'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, 'Best Time', 'Morning'),
                    const SizedBox(height: 8.0),
                    _buildInfoRow(context, 'Created By', 'Alex'),
                    const SizedBox(height: 8.0),
                    _buildInfoRow(context, 'Last Updated', 'May 12, 2025'),
                  ],
                ),
              ),
            ],
          ),

          const Divider(color: Colors.white24, height: 32.0),

          // Description
          Text(
            'Description',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 8.0),

          Text(
            'A scenic route through Central Park with a mix of flat sections and gentle hills. '
            'Great for morning runs with plenty of shade. The route passes by several landmarks '
            'and has water fountains along the way.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteStat(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24.0),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: valueColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialContext(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
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

          // Completed count
          Row(
            children: [
              const Icon(Icons.people, size: 18.0, color: Colors.white70),
              const SizedBox(width: 8.0),
              Text(
                '48 people completed this route',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Fastest times
          Text(
            'Fastest Times',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 8.0),

          // Leaderboard
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                _buildLeaderboardRow(context, '1', 'Sarah', '22:45', true),
                _buildDivider(),
                _buildLeaderboardRow(context, '2', 'Mike', '23:18', false),
                _buildDivider(),
                _buildLeaderboardRow(context, '3', 'Emma', '24:07', false),
                _buildDivider(),
                _buildLeaderboardRow(
                  context,
                  '4',
                  'You',
                  '25:32',
                  false,
                  isUser: true,
                ),
                _buildDivider(),
                _buildLeaderboardRow(context, '5', 'Alex', '26:15', false),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          // Recent activities
          Text(
            'Recent Activities',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 8.0),

          // Activity list
          _buildRecentActivityRow(context, 'Mike', 'Today', '26:45'),
          _buildDivider(),
          _buildRecentActivityRow(context, 'Sarah', 'Yesterday', '22:45'),
          _buildDivider(),
          _buildRecentActivityRow(context, 'You', '2 days ago', '25:32'),
        ],
      ),
    );
  }

  Widget _buildLeaderboardRow(
    BuildContext context,
    String rank,
    String name,
    String time,
    bool isFirst, {
    bool isUser = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      color: isUser ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 20.0,
            child: Text(
              rank,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isFirst ? Colors.amberAccent : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(
                name[0],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isUser ? Colors.white : Colors.white70,
              fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isFirst ? Colors.amberAccent : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityRow(
    BuildContext context,
    String name,
    String date,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          Text(
            time,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1.0, color: Colors.white.withValues(alpha: 0.1));
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassmorphicButton(
            opacity: 0.6,
            blur: 8.0,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: () {
              Navigator.push(
                context,
                // Changed from ActivityScreen to ActivityHistoryScreen
                MaterialPageRoute(
                  builder: (context) => const ActivityHistoryScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_arrow, size: 18.0, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Start Activity',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 12.0),

        Expanded(
          child: GlassmorphicButton(
            opacity: 0.4,
            blur: 5.0,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: () {
              // Navigate to directions
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions, size: 18.0, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Directions',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
