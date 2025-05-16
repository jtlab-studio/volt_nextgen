import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class TrainingZonesScreen extends StatefulWidget {
  const TrainingZonesScreen({super.key});

  @override
  State<TrainingZonesScreen> createState() => _TrainingZonesScreenState();
}

class _TrainingZonesScreenState extends State<TrainingZonesScreen> {
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider
  
  int _selectedTabIndex = 0; // 0: HR, 1: Power, 2: Pace
  bool _manualMode = false;
  
  // Sample data
  final int _lthr = 172;
  final int _criticalPower = 250;
  final String _threshold5K = '5:30';
  
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
                  Colors.red.shade800,
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
                    'Training Zones',
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
                
                // Threshold input section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildThresholdSection(context),
                  ),
                ),
                
                // Zone config controls
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildZoneConfigControls(context),
                  ),
                ),
                
                // Tab selector
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildTabSelector(context),
                  ),
                ),
                
                // Zones visualization
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildZonesVisualization(context),
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

  Widget _buildThresholdSection(BuildContext context) {
    return GlassmorphicCard(
      tier: _userTier,
      opacity: 0.6,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Training Thresholds',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // LTHR input
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          size: 18.0,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Lactate Threshold Heart Rate (LTHR)',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 16.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            // Show LTHR info
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$_lthr',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'bpm',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () {
                  // Edit LTHR
                },
                child: const Icon(
                  Icons.edit,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const Divider(
            color: Colors.white24,
            height: 32.0,
          ),
          
          // Critical Power input
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.flash_on,
                          size: 18.0,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Critical Power / FTP',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 16.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            // Show power info
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$_criticalPower',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'watts',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () {
                  // Edit power
                },
                child: const Icon(
                  Icons.edit,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const Divider(
            color: Colors.white24,
            height: 32.0,
          ),
          
          // 5K threshold pace
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.speed,
                          size: 18.0,
                          color: Colors.lightBlueAccent,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Threshold Pace (5K)',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 16.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            // Show pace info
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _threshold5K,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'min/km',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GlassmorphicButton(
                opacity: 0.4,
                blur: 5.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () {
                  // Edit pace
                },
                child: const Icon(
                  Icons.edit,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Calculate button
          GlassmorphicButton(
            opacity: 0.5,
            blur: 8.0,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            onPressed: () {
              // Calculate from test
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calculate,
                  size: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Calculate from Test',
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

  Widget _buildZoneConfigControls(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zone Configuration',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Number of zones selector
          Row(
            children: [
              Text(
                'Number of Zones',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      onPressed: () {
                        // Decrease zones
                      },
                    ),
                    Text(
                      '5',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      onPressed: () {
                        // Increase zones
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Auto-calculate toggle
          Row(
            children: [
              Text(
                'Auto-Calculate',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              Switch(
                value: !_manualMode,
                onChanged: (value) {
                  setState(() {
                    _manualMode = !value;
                  });
                },
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white.withOpacity(0.7),
                activeTrackColor: Colors.green.withOpacity(0.5),
                inactiveTrackColor: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          
          // Zone model selection
          Row(
            children: [
              Text(
                'Zone Model',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: 'Default',
                dropdownColor: Colors.indigo.shade800,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                underline: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.5),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                items: ['Default', 'Polarized', 'Friel', 'Custom']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  // Change zone model
                },
              ),
            ],
          ),
          
          const SizedBox(height: 8.0),
          
          // Last updated
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Last updated: May 10, 2025',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
              ),
            ],
          ),
        ],
      ),
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
                    'Heart Rate',
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
                    'Power',
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
                  color: _selectedTabIndex == 2
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Pace',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: _selectedTabIndex == 2
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

  Widget _buildZonesVisualization(BuildContext context) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHeartRateZones(context);
      case 1:
        return _buildPowerZones(context);
      case 2:
        return _buildPaceZones(context);
      default:
        return _buildHeartRateZones(context);
    }
  }

  Widget _buildHeartRateZones(BuildContext context) {
    // Heart rate zones with colors from Z1 (blue) to Z5 (red)
    final zoneColors = [
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    
    final zoneNames = [
      'Zone 1: Recovery',
      'Zone 2: Endurance',
      'Zone 3: Tempo',
      'Zone 4: Threshold',
      'Zone 5: VO2 Max',
    ];
    
    final zoneRanges = [
      '< 143 bpm',
      '143 - 154 bpm',
      '155 - 165 bpm',
      '166 - 172 bpm',
      '> 172 bpm',
    ];
    
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Heart Rate Zones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Zones visualization
          for (int i = 0; i < 5; i++)
            _buildZoneRow(
              context,
              zoneNames[i],
              zoneRanges[i],
              zoneColors[i],
              i == 3, // Threshold zone
            ),
          
          const SizedBox(height: 16.0),
          
          // Training benefits
          Text(
            'Training Benefits',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zone 1: Active recovery, improves fat metabolism',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Zone 2: Builds aerobic endurance and efficiency',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Zone 3: Improves aerobic capacity and lactate clearance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Zone 4: Raises lactate threshold and tolerance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Zone 5: Develops VO2 max and neuromuscular power',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

  Widget _buildPowerZones(BuildContext context) {
    // Power zone colors
    final zoneColors = [
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.pink,
    ];
    
    final zoneNames = [
      'Zone 1: Active Recovery',
      'Zone 2: Endurance',
      'Zone 3: Tempo',
      'Zone 4: Threshold',
      'Zone 5: VO2 Max',
      'Zone 6: Anaerobic',
      'Zone 7: Neuromuscular',
    ];
    
    final zoneRanges = [
      '< 150W (< 60% FTP)',
      '150 - 200W (60-80% FTP)',
      '200 - 225W (80-90% FTP)',
      '225 - 250W (90-100% FTP)',
      '250 - 300W (100-120% FTP)',
      '300 - 375W (120-150% FTP)',
      '> 375W (> 150% FTP)',
    ];
    
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Power Zones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Power zones visualization
          for (int i = 0; i < 7; i++)
            _buildZoneRow(
              context,
              zoneNames[i],
              zoneRanges[i],
              zoneColors[i],
              i == 3, // Threshold zone
            ),
          
          const SizedBox(height: 16.0),
          
          // Power curve
          Text(
            'Power Curve',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          // Power curve placeholder
          Container(
            height: 150.0,
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
                    'Power Curve Visualization',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaceZones(BuildContext context) {
    // Pace zones with colors from Z1 (blue) to Z5 (red)
    final zoneColors = [
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    
    final zoneNames = [
      'Zone 1: Easy',
      'Zone 2: Endurance',
      'Zone 3: Marathon',
      'Zone 4: Threshold',
      'Zone 5: Interval',
    ];
    
    final zoneRanges = [
      '> 6:35 /km',
      '6:35 - 6:05 /km',
      '6:05 - 5:45 /km',
      '5:45 - 5:30 /km',
      '< 5:30 /km',
    ];
    
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pace Zones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Pace zones visualization
          for (int i = 0; i < 5; i++)
            _buildZoneRow(
              context,
              zoneNames[i],
              zoneRanges[i],
              zoneColors[i],
              i == 3, // Threshold zone
            ),
          
          const SizedBox(height: 16.0),
          
          // Race equivalency
          Text(
            'Race Equivalency',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRaceEquivalent(context, '5K', '27:30'),
                const SizedBox(height: 4.0),
                _buildRaceEquivalent(context, '10K', '57:00'),
                const SizedBox(height: 4.0),
                _buildRaceEquivalent(context, 'Half Marathon', '2:05:00'),
                const SizedBox(height: 4.0),
                _buildRaceEquivalent(context, 'Marathon', '4:20:00'),
              ],
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Training paces
          Text(
            'Training Paces',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 8.0),
          
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTrainingPace(context, 'Recovery Run', '7:00 - 7:30 /km'),
                const SizedBox(height: 4.0),
                _buildTrainingPace(context, 'Long Run', '6:15 - 6:45 /km'),
                const SizedBox(height: 4.0),
                _buildTrainingPace(context, 'Tempo Run', '5:45 - 6:00 /km'),
                const SizedBox(height: 4.0),
                _buildTrainingPace(context, 'Intervals', '5:15 - 5:30 /km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneRow(
    BuildContext context,
    String zoneName,
    String zoneRange,
    Color zoneColor,
    bool isThreshold,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          // Zone color indicator
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: zoneColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          
          const SizedBox(width: 12.0),
          
          // Zone name and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  zoneName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: isThreshold ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
                Text(
                  zoneRange,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
          
          // Edit button (for manual mode)
          if (_manualMode)
            GlassmorphicButton(
              opacity: 0.3,
              blur: 5.0,
              padding: const EdgeInsets.all(8.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () {
                // Edit zone
              },
              child: const Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRaceEquivalent(BuildContext context, String distance, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          distance,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTrainingPace(BuildContext context, String type, String pace) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          pace,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassmorphicButton(
            opacity: 0.6,
            blur: 8.0,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            onPressed: () {
              // Save zones
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.save,
                  size: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Save',
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
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            onPressed: () {
              // Reset zones
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.refresh,
                  size: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Reset',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
