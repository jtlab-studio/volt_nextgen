import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class RouteCreationScreen extends StatefulWidget {
  const RouteCreationScreen({super.key});

  @override
  State<RouteCreationScreen> createState() => _RouteCreationScreenState();
}

class _RouteCreationScreenState extends State<RouteCreationScreen> {
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
                colors: [Colors.green.shade800, Colors.blue.shade900],
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
                    'Create Route',
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

                // Map editor
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildMapEditor(context),
                  ),
                ),

                // Route settings
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildRouteSettings(context),
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

  Widget _buildMapEditor(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Map Editor',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Map container
          Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                // Map placeholder
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 48.0,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Map Editor',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Map tools
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Column(
                    children: [
                      _buildMapToolButton(context, Icons.add_location, () {
                        // Add waypoint
                      }),
                      const SizedBox(height: 8.0),
                      _buildMapToolButton(context, Icons.edit, () {
                        // Edit route
                      }),
                      const SizedBox(height: 8.0),
                      _buildMapToolButton(context, Icons.delete, () {
                        // Delete waypoint
                      }),
                      const SizedBox(height: 8.0),
                      _buildMapToolButton(context, Icons.undo, () {
                        // Undo last action
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          // Route statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRouteStat(context, 'Distance', '0.0 km'),
              _buildRouteStat(context, 'Elevation', '0 m'),
              _buildRouteStat(context, 'Est. Time', '00:00'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapToolButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GlassmorphicButton(
      opacity: 0.5,
      blur: 5.0,
      padding: EdgeInsets.zero,
      height: 40.0,
      width: 40.0,
      isCircular: true,
      onPressed: onPressed,
      child: Icon(icon, size: 20.0, color: Colors.white),
    );
  }

  Widget _buildRouteStat(BuildContext context, String label, String value) {
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

  Widget _buildRouteSettings(BuildContext context) {
    return GlassmorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16.0),

          // Route name
          TextField(
            decoration: InputDecoration(
              labelText: 'Route Name',
              labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 16.0),

          // Route description
          TextField(
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
          ),

          const SizedBox(height: 16.0),

          // Difficulty
          Row(
            children: [
              Text(
                'Difficulty:',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 16.0),
              _buildDifficultyChip(context, 'Easy', true),
              const SizedBox(width: 8.0),
              _buildDifficultyChip(context, 'Moderate', false),
              const SizedBox(width: 8.0),
              _buildDifficultyChip(context, 'Hard', false),
            ],
          ),

          const SizedBox(height: 16.0),

          // Privacy settings
          Row(
            children: [
              Text(
                'Privacy:',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 16.0),
              _buildPrivacyChip(context, 'Public', true),
              const SizedBox(width: 8.0),
              _buildPrivacyChip(context, 'Friends', false),
              const SizedBox(width: 8.0),
              _buildPrivacyChip(context, 'Private', false),
            ],
          ),

          const SizedBox(height: 16.0),

          // Tags
          Text(
            'Tags:',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildTagChip(context, 'Road'),
              _buildTagChip(context, 'Trail'),
              _buildTagChip(context, 'Hill'),
              _buildTagChip(context, 'Flat'),
              _buildTagChip(context, 'Scenic'),
              _buildTagChip(context, '+ Add Tag'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        // Select difficulty
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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

  Widget _buildPrivacyChip(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        // Select privacy
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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

  Widget _buildTagChip(BuildContext context, String label) {
    final bool isAddTag = label == '+ Add Tag';

    return GestureDetector(
      onTap: () {
        // Add or select tag
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color:
              isAddTag
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: isAddTag ? 0.5 : 0.2),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: isAddTag ? FontWeight.normal : FontWeight.normal,
          ),
        ),
      ),
    );
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
              // Save route
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save, size: 18.0, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Save Route',
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
              // Cancel
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cancel, size: 18.0, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Cancel',
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
