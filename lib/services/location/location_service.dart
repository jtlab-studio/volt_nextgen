import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// Location service provider
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

// Location permission status provider
final locationPermissionProvider = StreamProvider<LocationPermission>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.permissionStatus;
});

// Current location provider
final currentLocationProvider = StreamProvider<LatLng?>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.locationUpdates;
});

// Current accuracy provider
final locationAccuracyProvider = Provider<LocationAccuracy>((ref) {
  return LocationAccuracy.high;
});

class LocationService {
  // Stream controllers
  final _locationController = StreamController<LatLng?>.broadcast();
  final _permissionController = StreamController<LocationPermission>.broadcast();
  
  // Stream getters
  Stream<LatLng?> get locationUpdates => _locationController.stream;
  Stream<LocationPermission> get permissionStatus => _permissionController.stream;
  
  // Active location subscription
  StreamSubscription<Position>? _positionSubscription;
  
  // Constructor
  LocationService() {
    // Check permission status on init
    _checkPermission();
  }
  
  // Check and request location permissions
  Future<bool> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      _permissionController.add(LocationPermission.denied);
      return false;
    }
    
    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied
        _permissionController.add(permission);
        return false;
      }
    }
    
    // Permission denied forever
    if (permission == LocationPermission.deniedForever) {
      _permissionController.add(permission);
      return false;
    }
    
    // Permission granted
    _permissionController.add(permission);
    return true;
  }
  
  // Request location permission
  Future<bool> requestPermission() async {
    return await _checkPermission();
  }
  
  // Start tracking location
  Future<bool> startTracking({LocationAccuracy accuracy = LocationAccuracy.high}) async {
    // Check permission first
    final hasPermission = await _checkPermission();
    if (!hasPermission) {
      return false;
    }
    
    // Stop any existing subscription
    await stopTracking();
    
    // Start new subscription
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: 5, // minimum distance (meters) before update
      ),
    ).listen(
      (Position position) {
        // Convert to LatLng and add to stream
        final latLng = LatLng(position.latitude, position.longitude);
        _locationController.add(latLng);
      },
      onError: (error) {
        print('Location service error: $error');
        _locationController.add(null);
      },
    );
    
    return true;
  }
  
  // Stop tracking location
  Future<void> stopTracking() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }
  
  // Get current location once
  Future<LatLng?> getCurrentLocation({LocationAccuracy accuracy = LocationAccuracy.high}) async {
    try {
      // Check permission first
      final hasPermission = await _checkPermission();
      if (!hasPermission) {
        return null;
      }
      
      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy,
      );
      
      // Convert to LatLng
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }
  
  // Calculate distance between two points in meters
  double calculateDistance(LatLng point1, LatLng point2) {
    return Geolocator.distanceBetween(
      point1.latitude,
      point1.longitude,
      point2.latitude,
      point2.longitude,
    );
  }
  
  // Calculate distance of a route (list of points) in kilometers
  double calculateRouteDistance(List<LatLng> points) {
    if (points.length < 2) {
      return 0.0;
    }
    
    double totalDistance = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      totalDistance += calculateDistance(points[i], points[i + 1]);
    }
    
    // Convert meters to kilometers
    return totalDistance / 1000.0;
  }
  
  // Dispose of resources
  void dispose() {
    stopTracking();
    _locationController.close();
    _permissionController.close();
  }
}
