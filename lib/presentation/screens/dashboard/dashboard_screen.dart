import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/activity/activity_screen.dart';
import 'package:volt_nextgen/presentation/screens/activity_history/activity_history_screen.dart';
import 'package:volt_nextgen/presentation/screens/routes/routes_screen.dart';
import 'package:volt_nextgen/presentation/screens/social/community_screen.dart';
import 'package:volt_nextgen/presentation/widgets/activity_card.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This would normally come from a user provider
    const currentTier = SocialTier.clan;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient based on time of day
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.purple.shade300,
                ],
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // Header section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildHeaderSection(context, currentTier),
                  ),
                ),
                
                // Activity overview
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildActivityOverview(context, currentTier),
                  ),
                ),
                
                // Quick actions section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildQuickActionsSection(context, currentTier),
                  ),
                ),
                
                // Recent activities
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildRecentActivities(context),
                  ),
                ),
                
                // Community feed
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCommunityFeed(context, currentTier),
                  ),
                ),
                
                // Future events
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildFutureEvents(context),
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

  Widget _buildHeaderSection(BuildContext context, SocialTier tier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // User greeting
            Text(
              'Welcome back, Alex',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            // Current status pill
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.people,
                    size: 16.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    tier.displayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Quick stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuickStat(context, 'Week\'s Distance', '26.4 km'),
            _buildQuickStat(context, 'Active Streak', '7 days'),
            _buildQuickStat(context, 'Group Rank', '#3'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStat(BuildContext context, String label, String value) {
    return GlassmorphicCard(
      opacity: 0.4,
      blur: 8.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOverview(BuildContext context, SocialTier tier) {
    return GlassmorphicCard(
      tier: tier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly total with glow
          Center(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 15.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '26.4 km',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'This Week',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Calendar week view (simplified)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final day = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index];
              final hasActivity = [true, false, true, true, false, true, false][index];
              
              return Column(
                children: [
                  Text(
                    day,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasActivity
                          ? Colors.white.withOpacity(0.3)
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          
          const SizedBox(height: 16.0),
          
          // Weekly comparison bar chart (simplified)
          SizedBox(
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(4, (index) {
                final labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                final heights = [65.0, 78.0, 69.0, 92.0];
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.0,
                      height: heights[index],
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      labels[index],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context, SocialTier tier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Start activity button
        Center(
          child: GlassmorphicButton(
            tier: tier,
            opacity: 0.7,
            height: 80,
            width: 80,
            isCircular: true,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 40.0,
              color: Colors.white,
            ),
          ),
        ),
        
        const SizedBox(height: 24.0),
        
        // Quick action cards
        SizedBox(
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildQuickActionCard(
                context,
                'Join Group Run',
                Icons.group_rounded,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunityScreen(),
                    ),
                  );
                },
              ),
              _buildQuickActionCard(
                context,
                'Create Route',
                Icons.map_rounded,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutesScreen(),
                    ),
                  );
                },
              ),
              _buildQuickActionCard(
                context,
                'View Challenges',
                Icons.emoji_events_rounded,
                () {
                  // Navigate to challenges screen
                },
              ),
              _buildQuickActionCard(
                context,
                'Training Plans',
                Icons.fitness_center_rounded,
                () {
                  // Navigate to training plans screen
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
      BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 8.0,
        padding: const EdgeInsets.all(12.0),
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            width: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Text(
              'Recent Activities',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 1.0,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Activity timeline
        SizedBox(
          height: 180.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ActivityCard(
                date: 'Today',
                type: 'Morning Run',
                distance: '5.2 km',
                time: '28:45',
                pace: '5:31/km',
              ),
              ActivityCard(
                date: 'Yesterday',
                type: 'Interval Training',
                distance: '3.8 km',
                time: '22:15',
                pace: '5:51/km',
              ),
              ActivityCard(
                date: 'May 14',
                type: 'Long Run',
                distance: '8.1 km',
                time: '47:30',
                pace: '5:52/km',
              ),
            ],
          ),
        ),
        
        // View all button
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityHistoryScreen(),
                ),
              );
            },
            child: Text(
              'View All Activities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityFeed(BuildContext context, SocialTier tier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Text(
              'Community Feed',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 1.0,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Community feed
        GlassmorphicCard(
          opacity: 0.5,
          blur: 15.0,
          tier: tier,
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              _buildFeedItem(
                context,
                'Sarah',
                'Morning Run',
                '5.8 km',
                '10 mins ago',
                '12 likes',
              ),
              _buildDivider(),
              _buildFeedItem(
                context,
                'Jake',
                'Interval Training',
                '4.2 km',
                '1 hour ago',
                '8 likes',
              ),
              _buildDivider(),
              _buildFeedItem(
                context,
                'Emma',
                'Hill Repeats',
                '3.5 km',
                '2 hours ago',
                '5 likes',
              ),
            ],
          ),
        ),
        
        // View community button
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommunityScreen(),
                ),
              );
            },
            child: Text(
              'View Community',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedItem(
    BuildContext context,
    String name,
    String activityType,
    String distance,
    String timeAgo,
    String likes,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                name[0],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          
          // Activity details
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
                    Text(
                      ' completed a ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                    Text(
                      activityType,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      distance,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      timeAgo,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.6),
                          ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.favorite,
                      color: Colors.white.withOpacity(0.8),
                      size: 14.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      likes,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.0,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildFutureEvents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Text(
              'Upcoming Events',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 1.0,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Events carousel
        SizedBox(
          height: 140.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildEventCard(
                context,
                'Saturday Group Run',
                'May 18, 8:00 AM',
                'Central Park',
                '12 participants',
              ),
              _buildEventCard(
                context,
                'Hill Training',
                'May 20, 6:30 PM',
                'River Valley',
                '8 participants',
              ),
              _buildEventCard(
                context,
                'Marathon Prep',
                'May 25, 7:00 AM',
                'Lakeside Trail',
                '15 participants',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String name,
    String dateTime,
    String location,
    String participants,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 10.0,
        borderRadius: BorderRadius.circular(12.0),
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white.withOpacity(0.8),
                    size: 14.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white.withOpacity(0.8),
                    size: 14.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.white.withOpacity(0.8),
                    size: 14.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    participants,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                onPressed: () {
                  // Join event
                },
                child: Center(
                  child: Text(
                    'Join',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
