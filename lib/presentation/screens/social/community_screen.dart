import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/social/community_health_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: true,
                    title: Text(
                      'Volt Runners',
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
                        icon: const Icon(Icons.health_and_safety, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommunityHealthScreen(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          // Open menu
                        },
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: GlassmorphicCard(
                        opacity: 0.5,
                        blur: 8.0,
                        borderRadius: BorderRadius.zero,
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.white,
                          tabs: const [
                            Tab(text: 'Feed'),
                            Tab(text: 'Members'),
                            Tab(text: 'Events'),
                            Tab(text: 'Challenges'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildCommunityHeader(context),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildTierStatus(context),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(context),
                  _buildMembersTab(context),
                  _buildEventsTab(context),
                  _buildChallengesTab(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityHeader(BuildContext context) {
    return Column(
      children: [
        // Community avatar
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 2.0,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.bolt,
              size: 40.0,
              color: Colors.amber,
            ),
          ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Community details
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQuickStat(context, 'Members', '8'),
            const SizedBox(width: 24.0),
            _buildQuickStat(context, 'Activities', '243'),
            const SizedBox(width: 24.0),
            _buildQuickStat(context, 'Tier', _userTier.displayName),
          ],
        ),
        
        const SizedBox(height: 8.0),
        
        Text(
          'A community of passionate runners pushing each other to reach new heights!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildQuickStat(BuildContext context, String label, String value) {
    return Column(
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
                color: Colors.white.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildTierStatus(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tier Status',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Tier benefits chips
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildBenefitChip(context, 'Group Analytics'),
              _buildBenefitChip(context, 'Event Creation'),
              _buildBenefitChip(context, 'Custom Challenges'),
              _buildBenefitChip(context, 'Member Roles'),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Progress to next tier
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Tribe',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    '65%',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8.0),
              
              // Progress bar
              Stack(
                children: [
                  // Background
                  Container(
                    height: 8.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  
                  // Progress
                  Container(
                    height: 8.0,
                    width: MediaQuery.of(context).size.width * 0.65 * 0.76, // 76% of card width (accounting for padding)
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12.0),
              
              // Requirements checklist
              _buildRequirementItem(context, 'Active Members', '8/10', false),
              _buildRequirementItem(context, 'Weekly Activities', '18/15', true),
              _buildRequirementItem(context, 'Total Distance', '156/200 km', false),
              
              const SizedBox(height: 8.0),
              
              // Estimated timeline
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 16.0,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Estimated time to Tribe: 3 weeks',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
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

  Widget _buildBenefitChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            size: 14.0,
            color: Colors.white,
          ),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(BuildContext context, String label, String progress, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16.0,
            color: isCompleted ? Colors.greenAccent : Colors.white70,
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Text(
            progress,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildFeedItem(
          context,
          'Sarah',
          'Morning Run',
          '5.8 km',
          '10 mins ago',
          '12 likes',
          'Great run today! Perfect weather for it.',
          hasImage: true,
        ),
        const SizedBox(height: 16.0),
        _buildFeedItem(
          context,
          'Jake',
          'Interval Training',
          '4.2 km',
          '1 hour ago',
          '8 likes',
          'Tough intervals today, but feeling stronger!',
          hasImage: false,
        ),
        const SizedBox(height: 16.0),
        _buildFeedItem(
          context,
          'Emma',
          'Hill Repeats',
          '3.5 km',
          '2 hours ago',
          '5 likes',
          'Those hills nearly killed me, but worth it for the views!',
          hasImage: true,
        ),
        const SizedBox(height: 16.0),
        _buildFeedItem(
          context,
          'Mike',
          'Recovery Run',
          '6.1 km',
          '5 hours ago',
          '10 likes',
          'Easy pace today after yesterday\'s hard session.',
          hasImage: false,
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
    String? comment,
    {bool hasImage = false},
  ) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
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
                                  color: Colors.white.withValues(alpha: 0.8),
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
                                  color: Colors.white.withValues(alpha: 0.6),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Show options
                  },
                ),
              ],
            ),
          ),
          
          // Image if present
          if (hasImage)
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 48.0,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          
          // Comment
          if (comment != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                comment,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          
          // Interaction bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Like button
                GestureDetector(
                  onTap: () {
                    // Like post
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16.0),
                
                // Comment button
                GestureDetector(
                  onTap: () {
                    // Comment
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Comment',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Like count
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 16.0,
                      color: Colors.pinkAccent,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      likes,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
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

  Widget _buildMembersTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildMemberCard(context, 'Sarah', 'Admin', '156 km this month', 0),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Jake', 'Coach', '132 km this month', 1),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Emma', 'Member', '98 km this month', 2),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Mike', 'Member', '112 km this month', 3),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Alex', 'Member', '87 km this month', 4),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Lisa', 'Member', '65 km this month', 5),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Chris', 'Member', '43 km this month', 6),
        const SizedBox(height: 8.0),
        _buildMemberCard(context, 'Rachel', 'Member', '78 km this month', 7),
        
        const SizedBox(height: 16.0),
        
        // Add member button
        GlassmorphicButton(
          opacity: 0.6,
          blur: 8.0,
          onPressed: () {
            // Invite member
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_add,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Invite New Member',
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

  Widget _buildMemberCard(BuildContext context, String name, String role, String stats, int rank) {
    Color roleColor;
    
    switch (role) {
      case 'Admin':
        roleColor = Colors.amber;
        break;
      case 'Coach':
        roleColor = Colors.lightBlueAccent;
        break;
      default:
        roleColor = Colors.white.withValues(alpha: 0.8);
    }
    
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // Rank
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(
                '#${rank + 1}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          
          const SizedBox(width: 12.0),
          
          // Avatar
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
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
          
          // Details
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
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        role,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: roleColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  stats,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                ),
              ],
            ),
          ),
          
          // Actions
          IconButton(
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              // Message user
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            GlassmorphicButton(
              opacity: 0.4,
              blur: 5.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
              onPressed: () {
                // Create event
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    size: 16.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Create',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Events
        _buildEventCard(
          context,
          'Saturday Group Run',
          'May 18, 8:00 AM',
          'Central Park',
          '12 participants',
          'A relaxed group run followed by coffee!',
        ),
        const SizedBox(height: 12.0),
        _buildEventCard(
          context,
          'Hill Training',
          'May 20, 6:30 PM',
          'River Valley',
          '8 participants',
          'Building strength with hill repeats. All levels welcome!',
        ),
        const SizedBox(height: 12.0),
        _buildEventCard(
          context,
          'Marathon Prep',
          'May 25, 7:00 AM',
          'Lakeside Trail',
          '15 participants',
          'Long run for everyone training for the upcoming marathon.',
        ),
        
        const SizedBox(height: 24.0),
        
        // Past events header
        Text(
          'Past Events',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Past events
        _buildEventCard(
          context,
          'Interval Session',
          'May 13, 6:00 PM',
          'Track Field',
          '10 participants',
          '800m repeats with 2 min recovery.',
          isPast: true,
        ),
        const SizedBox(height: 12.0),
        _buildEventCard(
          context,
          'Recovery Run',
          'May 11, 7:30 AM',
          'City Park',
          '7 participants',
          'Easy pace, social run to recover from weekend efforts.',
          isPast: true,
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
    String description, {
    bool isPast = false,
  }) {
    return GlassmorphicCard(
      opacity: isPast ? 0.3 : 0.5,
      blur: 8.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (!isPast)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'Going',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12.0),
          
          // Details
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16.0,
                color: Colors.white70,
              ),
              const SizedBox(width: 8.0),
              Text(
                dateTime,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 6.0),
          
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16.0,
                color: Colors.white70,
              ),
              const SizedBox(width: 8.0),
              Text(
                location,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 6.0),
          
          Row(
            children: [
              const Icon(
                Icons.people,
                size: 16.0,
                color: Colors.white70,
              ),
              const SizedBox(width: 8.0),
              Text(
                participants,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 12.0),
          
          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          if (!isPast) ...[
            const SizedBox(height: 16.0),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: GlassmorphicButton(
                    opacity: 0.4,
                    blur: 5.0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    onPressed: () {
                      // View details
                    },
                    child: Text(
                      'Details',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GlassmorphicButton(
                    opacity: 0.4,
                    blur: 5.0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    onPressed: () {
                      // Share
                    },
                    child: Text(
                      'Share',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChallengesTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Active challenges header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Challenges',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            GlassmorphicButton(
              opacity: 0.4,
              blur: 5.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
              onPressed: () {
                // Create challenge
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    size: 16.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Create',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Active challenges
        _buildChallengeCard(
          context,
          'May Distance Challenge',
          'Run 100km this month',
          '18 days left',
          0.65,
          '65/100 km',
          '#3 of 8 participants',
          'Complete 100km of running this month to earn the badge!',
        ),
        const SizedBox(height: 12.0),
        _buildChallengeCard(
          context,
          'Hill Climber',
          'Climb 1000m of elevation',
          '10 days left',
          0.42,
          '420/1000 m',
          '#5 of 8 participants',
          'Take on those hills and reach the 1000m elevation gain goal!',
        ),
        
        const SizedBox(height: 24.0),
        
        // Available challenges header
        Text(
          'Available Challenges',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Available challenges
        _buildAvailableChallengeCard(
          context,
          'Sprint Master',
          'Complete 10 sprint workouts',
          'Medium',
          'Badge + 100 points',
          'Put your speed to the test with this sprint workout challenge!',
        ),
        const SizedBox(height: 12.0),
        _buildAvailableChallengeCard(
          context,
          'Early Bird',
          'Run 5 times before 7 AM',
          'Easy',
          'Badge + 50 points',
          'Rise and shine! Get those morning miles in to earn your badge.',
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
    BuildContext context,
    String name,
    String goal,
    String timeLeft,
    double progress,
    String progressText,
    String ranking,
    String description,
  ) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      goal,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  timeLeft,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    progressText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8.0),
              
              // Progress bar
              Stack(
                children: [
                  // Background
                  Container(
                    height: 8.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  
                  // Progress
                  Container(
                    height: 8.0,
                    width: MediaQuery.of(context).size.width * progress * 0.76, // Accounting for padding
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8.0),
              
              // Ranking
              Text(
                ranking,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 12.0),
          
          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: GlassmorphicButton(
                  opacity: 0.4,
                  blur: 5.0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  onPressed: () {
                    // View leaderboard
                  },
                  child: Text(
                    'Leaderboard',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: GlassmorphicButton(
                  opacity: 0.4,
                  blur: 5.0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  onPressed: () {
                    // View details
                  },
                  child: Text(
                    'Details',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
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

  Widget _buildAvailableChallengeCard(
    BuildContext context,
    String name,
    String goal,
    String difficulty,
    String reward,
    String description,
  ) {
    return GlassmorphicCard(
      opacity: 0.4,
      blur: 8.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      goal,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  difficulty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12.0),
          
          // Reward
          Row(
            children: [
              const Icon(
                Icons.card_giftcard,
                size: 16.0,
                color: Colors.white70,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Reward: $reward',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 12.0),
          
          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Join button
          GlassmorphicButton(
            opacity: 0.5,
            blur: 5.0,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            onPressed: () {
              // Join challenge
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  size: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Join Challenge',
                  textAlign: TextAlign.center,
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
    );
  }
}