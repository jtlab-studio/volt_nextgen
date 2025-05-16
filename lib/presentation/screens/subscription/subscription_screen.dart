import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider
  
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
                  Colors.blue.shade600,
                  Colors.purple.shade700,
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
                    'Subscription',
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
                
                // Current plan section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCurrentPlanSection(context),
                  ),
                ),
                
                // Social benefits
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSocialBenefitsSection(context),
                  ),
                ),
                
                // Upgrade pathways
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildUpgradePathwaysSection(context),
                  ),
                ),
                
                // Community building tools
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildCommunityToolsSection(context),
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

  Widget _buildCurrentPlanSection(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      _userTier.displayName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24.0),
          
          // Plan details
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '\$9.99',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'per month',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Billing info
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  context,
                  'Billing Cycle',
                  'Monthly',
                  Icons.calendar_today,
                ),
                const SizedBox(height: 8.0),
                _buildInfoRow(
                  context,
                  'Next Payment',
                  'June 15, 2025',
                  Icons.event,
                ),
                const SizedBox(height: 8.0),
                _buildInfoRow(
                  context,
                  'Payment Method',
                  '•••• 4242',
                  Icons.credit_card,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Tier description
          Text(
            _userTier.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.0,
          color: Colors.white.withOpacity(0.7),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
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

  Widget _buildSocialBenefitsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Benefits',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Benefits grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.3,
          children: [
            _buildBenefitCard(
              context,
              'Group Creation',
              'Create groups with up to 5 members',
              Icons.group,
              true,
            ),
            _buildBenefitCard(
              context,
              'Group Analytics',
              'Track group performance and progress',
              Icons.analytics,
              true,
            ),
            _buildBenefitCard(
              context,
              'Event Creation',
              'Organize group events and activities',
              Icons.event,
              true,
            ),
            _buildBenefitCard(
              context,
              'Challenge Creation',
              'Create custom challenges for your group',
              Icons.emoji_events,
              true,
            ),
            _buildBenefitCard(
              context,
              'Custom Routes',
              'Create and share custom routes',
              Icons.map,
              true,
            ),
            _buildBenefitCard(
              context,
              'Advanced Stats',
              'Access detailed performance metrics',
              Icons.bar_chart,
              true,
            ),
            _buildBenefitCard(
              context,
              'Leadership Roles',
              'Assign roles within your group',
              Icons.admin_panel_settings,
              false,
              isLocked: true,
              unlocksAt: 'Tribe',
            ),
            _buildBenefitCard(
              context,
              'Custom Branding',
              'Add unique branding to your group',
              Icons.brush,
              false,
              isLocked: true,
              unlocksAt: 'Chiefdom',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBenefitCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    bool isActive, {
    bool isLocked = false,
    String? unlocksAt,
  }) {
    return GlassmorphicCard(
      opacity: isActive ? 0.5 : 0.3,
      blur: 8.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                size: 32.0,
                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
              ),
              if (isLocked)
                const Icon(
                  Icons.lock,
                  size: 16.0,
                  color: Colors.white,
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            isLocked && unlocksAt != null
                ? 'Unlocks at $unlocksAt tier'
                : description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isActive ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradePathwaysSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upgrade Pathways',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        GlassmorphicCard(
          opacity: 0.5,
          blur: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tier Progression',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              
              const SizedBox(height: 16.0),
              
              // Tier progression visualization
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTierNode(context, SocialTier.loneWolf, false, isFirst: true),
                  _buildTierConnector(context, false),
                  _buildTierNode(context, SocialTier.clan, true),
                  _buildTierConnector(context, true),
                  _buildTierNode(context, SocialTier.tribe, false),
                  _buildTierConnector(context, false),
                  _buildTierNode(context, SocialTier.chiefdom, false, isLast: true),
                ],
              ),
              
              const SizedBox(height: 16.0),
              
              // Requirements explanation
              Text(
                'Upgrade Requirements',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              
              const SizedBox(height: 8.0),
              
              _buildRequirementItem(context, '10+ active members', false),
              _buildRequirementItem(context, '200+ km monthly distance', false),
              _buildRequirementItem(context, '15+ weekly activities', true),
              
              const SizedBox(height: 16.0),
              
              // Timeline
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 16.0,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Estimated time to Tribe: 3 weeks',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTierNode(
    BuildContext context,
    SocialTier tier,
    bool isActive, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            border: Border.all(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              tier.displayName[0],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          tier.displayName,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }

  Widget _buildTierConnector(BuildContext context, bool isActive) {
    return Container(
      width: 20.0,
      height: 2.0,
      color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
    );
  }

  Widget _buildRequirementItem(BuildContext context, String text, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16.0,
            color: isCompleted ? Colors.green : Colors.white.withOpacity(0.6),
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityToolsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Community Building Tools',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Growth dashboard
        GlassmorphicCard(
          opacity: 0.5,
          blur: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Growth Dashboard',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              
              const SizedBox(height: 12.0),
              
              // Member recruitment progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Member Recruitment',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        '8/10',
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
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      
                      // Progress
                      Container(
                        height: 8.0,
                        width: MediaQuery.of(context).size.width * 0.8 * 0.76, // 80% of available width (accounting for padding)
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16.0),
              
              // Invitation system
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invitation System',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '3 pending invitations',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                  GlassmorphicButton(
                    opacity: 0.4,
                    blur: 5.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    onPressed: () {
                      // Invite members
                    },
                    child: Text(
                      'Invite',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16.0),
              
              // QR code generator
              Row(
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.qr_code,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QR Invitation Code',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Share this code to let others join your community quickly',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            GlassmorphicButton(
                              opacity: 0.4,
                              blur: 5.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 6.0,
                              ),
                              onPressed: () {
                                // Show QR code
                              },
                              child: Text(
                                'Show Code',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Health metrics
        GlassmorphicCard(
          opacity: 0.5,
          blur: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community Health',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              
              const SizedBox(height: 12.0),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHealthMetric(context, 'Activity Rate', '92%', Icons.directions_run, Colors.green),
                  _buildHealthMetric(context, 'Retention', '100%', Icons.people, Colors.green),
                  _buildHealthMetric(context, 'Engagement', '78%', Icons.chat_bubble, Colors.orange),
                ],
              ),
              
              const SizedBox(height: 16.0),
              
              // Weekly health report
              Row(
                children: [
                  const Icon(
                    Icons.summarize,
                    size: 18.0,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Weekly health report available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ),
                  GlassmorphicButton(
                    opacity: 0.4,
                    blur: 5.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    onPressed: () {
                      // View report
                    },
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthMetric(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.0,
          color: color,
        ),
        const SizedBox(height: 4.0),
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
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GlassmorphicButton(
          opacity: 0.6,
          blur: 8.0,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          onPressed: () {
            // Manage subscription
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.settings,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Manage Subscription',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12.0),
        
        GlassmorphicButton(
          opacity: 0.4,
          blur: 5.0,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          onPressed: () {
            // View billing history
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.receipt_long,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Text(
                'View Billing History',
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
