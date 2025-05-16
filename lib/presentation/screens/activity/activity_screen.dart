import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/activity/activity_summary_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';
import 'package:volt_nextgen/presentation/widgets/metric_card.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool _isTracking = false;
  int _elapsedSeconds = 0;
  int _selectedTabIndex = 0; // 0: Metrics, 1: Map
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with blur (would be a map in real implementation)
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
            child: Column(
              children: [
                // Sensor status bar
                _buildSensorStatusBar(context),
                
                // Content tabs
                Expanded(
                  child: _isTracking
                      ? _buildTabContent(context)
                      : _buildPreStartState(context),
                ),
                
                // Control panel
                _buildControlPanel(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSensorStatusBar(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.5,
      blur: 8.0,
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSensorStatus(context, 'GPS', true),
          _buildSensorStatus(context, 'HR', true),
          _buildSensorStatus(context, 'Power', false),
        ],
      ),
    );
  }

  Widget _buildSensorStatus(BuildContext context, String label, bool isConnected) {
    return Row(
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isConnected ? Colors.green : Colors.red.shade300,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget _buildPreStartState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Central start button
          GlassmorphicButton(
            tier: _userTier,
            opacity: 0.7,
            blur: 10.0,
            height: 100.0,
            width: 100.0,
            isCircular: true,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _isTracking = true;
              });
            },
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 60.0,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 32.0),
          
          // Quick settings
          GlassmorphicCard(
            opacity: 0.6,
            blur: 8.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              children: [
                _buildActivityTypeSelector(context),
                const SizedBox(height: 16.0),
                _buildSettingsRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTypeSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildActivityTypes(context),
    );
  }

  List<Widget> _buildActivityTypes(BuildContext context) {
    final activities = ['Run', 'Walk', 'Bike', 'Hike'];
    final icons = [Icons.directions_run, Icons.directions_walk, Icons.directions_bike, Icons.terrain];
    
    return List.generate(activities.length, (index) {
      final isSelected = index == 0; // Default to Run
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GlassmorphicButton(
          opacity: isSelected ? 0.7 : 0.5,
          blur: 8.0,
          borderRadius: BorderRadius.circular(16.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          onPressed: () {
            // Select activity type
          },
          child: Row(
            children: [
              Icon(
                icons[index],
                size: 16.0,
                color: Colors.white,
              ),
              const SizedBox(width: 4.0),
              Text(
                activities[index],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSettingsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSettingToggle(context, 'Audio', Icons.volume_up, true),
        _buildSettingToggle(context, 'GPS', Icons.location_on, true),
        _buildSettingToggle(context, 'Auto Pause', Icons.pause_circle_outline, false),
      ],
    );
  }

  Widget _buildSettingToggle(BuildContext context, String label, IconData icon, bool isEnabled) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18.0,
          color: isEnabled ? Colors.white : Colors.white.withOpacity(0.5),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.5),
              ),
        ),
        Switch(
          value: isEnabled,
          onChanged: (value) {
            // Toggle setting
          },
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white.withOpacity(0.3),
          activeTrackColor: Colors.white.withOpacity(0.3),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
      ],
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Column(
      children: [
        // Tab selector
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassmorphicCard(
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
                          'Metrics',
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
                          'Map',
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
          ),
        ),
        
        // Tab content
        Expanded(
          child: _selectedTabIndex == 0
              ? _buildMetricsView(context)
              : _buildMapView(context),
        ),
      ],
    );
  }

  Widget _buildMetricsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: [
          MetricCard(
            label: 'Time',
            value: _formatElapsedTime(),
            isLarge: true,
            icon: Icons.timer,
          ),
          MetricCard(
            label: 'Distance',
            value: '2.45',
            unit: 'km',
            isLarge: true,
            icon: Icons.straighten,
          ),
          MetricCard(
            label: 'Pace',
            value: '5:21',
            unit: '/km',
            icon: Icons.speed,
          ),
          MetricCard(
            label: 'Heart Rate',
            value: '148',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.redAccent,
          ),
          MetricCard(
            label: 'Cadence',
            value: '172',
            unit: 'spm',
            icon: Icons.repeat,
          ),
          MetricCard(
            label: 'Elevation',
            value: '58',
            unit: 'm',
            icon: Icons.terrain,
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(BuildContext context) {
    // This would be a real map in the actual implementation
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 48.0,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Map View',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context) {
    return GlassmorphicCard(
      opacity: 0.7,
      blur: 10.0,
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: _isTracking
          ? _buildActiveControls(context)
          : Container(
              height: 48.0,
              color: Colors.transparent,
            ),
    );
  }

  Widget _buildActiveControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Lap button
        GlassmorphicButton(
          opacity: 0.6,
          blur: 8.0,
          height: 56.0,
          width: 56.0,
          isCircular: true,
          padding: EdgeInsets.zero,
          onPressed: () {
            // Add lap
          },
          child: const Icon(
            Icons.flag,
            size: 24.0,
            color: Colors.white,
          ),
        ),
        
        // Pause button
        GlassmorphicButton(
          opacity: 0.7,
          blur: 8.0,
          height: 64.0,
          width: 64.0,
          isCircular: true,
          padding: EdgeInsets.zero,
          onPressed: () {
            // Navigate to summary
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ActivitySummaryScreen(
                  distance: '2.45',
                  time: '00:13:12',
                  pace: '5:23',
                  heartRate: '148',
                ),
              ),
            );
          },
          child: const Icon(
            Icons.stop,
            size: 32.0,
            color: Colors.white,
          ),
        ),
        
        // Lock button
        GlassmorphicButton(
          opacity: 0.6,
          blur: 8.0,
          height: 56.0,
          width: 56.0,
          isCircular: true,
          padding: EdgeInsets.zero,
          onPressed: () {
            // Lock screen
          },
          child: const Icon(
            Icons.lock_outline,
            size: 24.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _formatElapsedTime() {
    final hours = (_elapsedSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    
    return '$hours:$minutes:$seconds';
  }
}
