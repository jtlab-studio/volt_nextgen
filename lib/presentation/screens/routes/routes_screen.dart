import 'package:flutter/material.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/presentation/screens/routes/route_creation_screen.dart';
import 'package:volt_nextgen/presentation/screens/routes/route_detail_screen.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_button.dart';
import 'package:volt_nextgen/presentation/widgets/glassmorphic/glassmorphic_card.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final SocialTier _userTier = SocialTier.clan; // Would normally come from a provider
  
  bool _mapView = true; // true: map view, false: list view
  String _selectedFilter = 'All'; // All, Favorites, Created
  
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
                  Colors.green.shade800,
                  Colors.blue.shade900,
                ],
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                // App bar
                _buildAppBar(context),
                
                // Search and filters
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSearchAndFilters(context),
                ),
                
                // Map/list toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildViewToggle(context),
                ),
                
                // Routes display (map or list)
                Expanded(
                  child: _mapView
                      ? _buildMapView(context)
                      : _buildListView(context),
                ),
              ],
            ),
          ),
          
          // FAB for creating new route
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: GlassmorphicButton(
              tier: _userTier,
              opacity: 0.7,
              height: 56.0,
              width: 56.0,
              isCircular: true,
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RouteCreationScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Routes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () {
              // Show additional filters
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // Show menu
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return Column(
      children: [
        // Search bar
        GlassmorphicCard(
          opacity: 0.5,
          blur: 8.0,
          borderRadius: BorderRadius.circular(24.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search routes',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Use current location
                },
                child: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16.0),
        
        // Filter chips
        Row(
          children: [
            _buildFilterChip(context, 'All'),
            const SizedBox(width: 8.0),
            _buildFilterChip(context, 'Favorites'),
            const SizedBox(width: 8.0),
            _buildFilterChip(context, 'Created'),
          ],
        ),
        
        const SizedBox(height: 16.0),
        
        // Distance filter
        GlassmorphicCard(
          opacity: 0.4,
          blur: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distance: 3-10 km',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8.0),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.3),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withOpacity(0.1),
                ),
                child: RangeSlider(
                  values: const RangeValues(3, 10),
                  min: 1,
                  max: 42,
                  divisions: 41,
                  onChanged: (RangeValues values) {
                    // Update distance range
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    final isSelected = _selectedFilter == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }

  Widget _buildViewToggle(BuildContext context) {
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
                  _mapView = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: _mapView
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 18.0,
                      color: Colors.white,
                      opacity: _mapView ? 1.0 : 0.7,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Map',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: _mapView
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _mapView = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: !_mapView
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      size: 18.0,
                      color: Colors.white,
                      opacity: !_mapView ? 1.0 : 0.7,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'List',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: !_mapView
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(BuildContext context) {
    return Stack(
      children: [
        // Map placeholder
        Container(
          color: Colors.white.withOpacity(0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 48.0,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Map View',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
        
        // Route cards (scrollable at bottom)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 200.0,
            padding: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildRouteCard(
                  context,
                  'Central Park Loop',
                  '5.2 km',
                  'Easy',
                  true,
                ),
                _buildRouteCard(
                  context,
                  'Riverside Trail',
                  '8.7 km',
                  'Moderate',
                  false,
                ),
                _buildRouteCard(
                  context,
                  'Downtown Circuit',
                  '3.5 km',
                  'Easy',
                  true,
                ),
                _buildRouteCard(
                  context,
                  'Hill Challenge',
                  '6.8 km',
                  'Hard',
                  false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildRouteListItem(
          context,
          'Central Park Loop',
          '5.2 km',
          'Easy',
          true,
        ),
        _buildRouteListItem(
          context,
          'Riverside Trail',
          '8.7 km',
          'Moderate',
          false,
        ),
        _buildRouteListItem(
          context,
          'Downtown Circuit',
          '3.5 km',
          'Easy',
          true,
        ),
        _buildRouteListItem(
          context,
          'Hill Challenge',
          '6.8 km',
          'Hard',
          false,
        ),
        _buildRouteListItem(
          context,
          'Forest Path',
          '12.3 km',
          'Moderate',
          false,
        ),
        _buildRouteListItem(
          context,
          'Lake Circuit',
          '7.5 km',
          'Easy',
          true,
        ),
        _buildRouteListItem(
          context,
          'Mountain Trail',
          '15.8 km',
          'Hard',
          false,
        ),
      ],
    );
  }

  Widget _buildRouteCard(
    BuildContext context,
    String name,
    String distance,
    String difficulty,
    bool isFavorite,
  ) {
    Color difficultyColor;
    switch (difficulty) {
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
    
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 8.0,
        padding: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RouteDetailScreen(
                  routeName: name,
                  distance: distance,
                  difficulty: difficulty,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: SizedBox(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map thumbnail
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.map,
                          size: 32.0,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: GestureDetector(
                          onTap: () {
                            // Toggle favorite
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Details
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.straighten,
                                  size: 12.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  distance,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: difficultyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 12.0,
                                  color: difficultyColor,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  difficulty,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRouteListItem(
    BuildContext context,
    String name,
    String distance,
    String difficulty,
    bool isFavorite,
  ) {
    Color difficultyColor;
    switch (difficulty) {
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
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassmorphicCard(
        opacity: 0.5,
        blur: 8.0,
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RouteDetailScreen(
                  routeName: name,
                  distance: distance,
                  difficulty: difficulty,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Row(
            children: [
              // Route thumbnail
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.map,
                    size: 24.0,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              
              const SizedBox(width: 16.0),
              
              // Details
              Expanded(
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.straighten,
                                size: 12.0,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                distance,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: difficultyColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 12.0,
                                color: difficultyColor,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                difficulty,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Favorite button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  // Toggle favorite
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
