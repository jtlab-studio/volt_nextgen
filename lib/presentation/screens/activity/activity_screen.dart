import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_nextgen/data/models/activity_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

// Provider for list of activities
final activitiesProvider =
    StateNotifierProvider<ActivityNotifier, List<ActivityModel>>(
      (ref) => ActivityNotifier(),
    );

// Provider for current activity tracking
final currentActivityProvider =
    StateNotifierProvider<CurrentActivityNotifier, ActivityTrackingState>(
      (ref) => CurrentActivityNotifier(),
    );

// Provider for activity metrics in real-time
final activityMetricsProvider = Provider<ActivityMetricsState>((ref) {
  final trackingState = ref.watch(currentActivityProvider);
  if (trackingState.status == ActivityStatus.inactive) {
    return ActivityMetricsState.empty();
  }

  return ActivityMetricsState(
    distance: trackingState.distance,
    duration: trackingState.duration,
    currentPace: trackingState.currentPace,
    avgPace: trackingState.avgPace,
    currentHeartRate: trackingState.currentHeartRate,
    avgHeartRate: trackingState.avgHeartRate,
    currentCadence: trackingState.currentCadence,
    avgCadence: trackingState.avgCadence,
    currentPower: trackingState.currentPower,
    avgPower: trackingState.avgPower,
    elevation: trackingState.elevation,
    elevationGain: trackingState.elevationGain,
    calories: trackingState.calories,
  );
});

class ActivityNotifier extends StateNotifier<List<ActivityModel>> {
  ActivityNotifier() : super(_generateSampleActivities());

  // Add a new activity
  void addActivity(ActivityModel activity) {
    state = [...state, activity];
  }

  // Delete an activity
  void deleteActivity(String activityId) {
    state = state.where((activity) => activity.id != activityId).toList();
  }

  // Update an activity
  void updateActivity(ActivityModel updatedActivity) {
    state =
        state.map((activity) {
          if (activity.id == updatedActivity.id) {
            return updatedActivity;
          }
          return activity;
        }).toList();
  }

  // Like an activity
  void toggleLike(String activityId, String userId) {
    state =
        state.map((activity) {
          if (activity.id == activityId) {
            final likedByUserIds = List<String>.from(activity.likedByUserIds);
            if (likedByUserIds.contains(userId)) {
              likedByUserIds.remove(userId);
            } else {
              likedByUserIds.add(userId);
            }
            return activity.copyWith(likedByUserIds: likedByUserIds);
          }
          return activity;
        }).toList();
  }

  // Add a comment to an activity
  void addComment(String activityId, CommentModel comment) {
    state =
        state.map((activity) {
          if (activity.id == activityId) {
            final comments = List<CommentModel>.from(activity.comments)
              ..add(comment);
            return activity.copyWith(comments: comments);
          }
          return activity;
        }).toList();
  }

  // Get activities for a specific user
  List<ActivityModel> getActivitiesForUser(String userId) {
    return state.where((activity) => activity.userId == userId).toList();
  }

  // Get public activities only
  List<ActivityModel> getPublicActivities() {
    return state.where((activity) => activity.isPublic).toList();
  }

  // Filter activities by type
  List<ActivityModel> getActivitiesByType(ActivityType type) {
    return state.where((activity) => activity.type == type).toList();
  }

  // Filter activities by date range
  List<ActivityModel> getActivitiesByDateRange(DateTime start, DateTime end) {
    return state.where((activity) {
      return activity.startTime.isAfter(start) &&
          activity.startTime.isBefore(end);
    }).toList();
  }

  // Sort activities by various criteria
  List<ActivityModel> getSortedActivities({
    required ActivitySortBy sortBy,
    bool ascending = false,
  }) {
    final sortedList = List<ActivityModel>.from(state);
    switch (sortBy) {
      case ActivitySortBy.date:
        sortedList.sort((a, b) {
          return ascending
              ? a.startTime.compareTo(b.startTime)
              : b.startTime.compareTo(a.startTime);
        });
        break;
      case ActivitySortBy.distance:
        sortedList.sort((a, b) {
          return ascending
              ? a.distance.compareTo(b.distance)
              : b.distance.compareTo(a.distance);
        });
        break;
      case ActivitySortBy.duration:
        sortedList.sort((a, b) {
          return ascending
              ? a.duration.compareTo(b.duration)
              : b.duration.compareTo(a.duration);
        });
        break;
      case ActivitySortBy.pace:
        sortedList.sort((a, b) {
          // For pace, lower is faster so we invert the comparison
          final aPace = a.duration / a.distance;
          final bPace = b.duration / b.distance;
          return ascending ? bPace.compareTo(aPace) : aPace.compareTo(bPace);
        });
        break;
    }
    return sortedList;
  }
}

enum ActivitySortBy { date, distance, duration, pace }

class CurrentActivityNotifier extends StateNotifier<ActivityTrackingState> {
  CurrentActivityNotifier() : super(ActivityTrackingState());

  // Start a new activity
  void startActivity({required ActivityType type}) {
    state = ActivityTrackingState(
      status: ActivityStatus.active,
      activityType: type,
      startTime: DateTime.now(),
    );
  }

  // Pause the current activity
  void pauseActivity() {
    if (state.status == ActivityStatus.active) {
      state = state.copyWith(
        status: ActivityStatus.paused,
        pauseTime: DateTime.now(),
      );
    }
  }

  // Resume a paused activity
  void resumeActivity() {
    if (state.status == ActivityStatus.paused) {
      final pauseDuration =
          DateTime.now().difference(state.pauseTime!).inSeconds;
      state = state.copyWith(
        status: ActivityStatus.active,
        pauseTime: null,
        totalPauseTime: state.totalPauseTime + pauseDuration,
      );
    }
  }

  // Stop the current activity
  ActivityModel stopActivity({
    required String userId,
    required String title,
    bool isPublic = true,
  }) {
    final distance = state.distance;
    final duration = state.duration;

    // Create completed activity model
    final completedActivity = ActivityModel(
      id: const Uuid().v4(),
      userId: userId,
      title: title,
      type: state.activityType,
      startTime: state.startTime,
      duration: duration,
      distance: distance,
      routeId: null,
      gpsTrace: state.gpsPoints,
      isPublic: isPublic,
      metrics: ActivityMetrics(
        heartRateData: state.heartRateData,
        cadenceData: state.cadenceData,
        elevationData: state.elevationData,
        powerData: state.powerData,
        averageHeartRate: state.avgHeartRate,
        maxHeartRate:
            state.heartRateData.isNotEmpty
                ? state.heartRateData.reduce((a, b) => a > b ? a : b)
                : null,
        averageCadence: state.avgCadence,
        maxCadence:
            state.cadenceData.isNotEmpty
                ? state.cadenceData.reduce((a, b) => a > b ? a : b)
                : null,
        averagePower: state.avgPower,
        maxPower:
            state.powerData.isNotEmpty
                ? state.powerData.reduce((a, b) => a > b ? a : b)
                : null,
        caloriesBurned: state.calories,
      ),
      laps: state.laps,
      likedByUserIds: [],
      comments: [],
    );

    // Reset state
    state = ActivityTrackingState();

    return completedActivity;
  }

  // Update tracking metrics
  void updateMetrics({
    double? distanceDelta,
    LatLng? newPosition,
    int? heartRate,
    int? cadence,
    int? power,
    double? elevation,
  }) {
    if (state.status != ActivityStatus.active) {
      return;
    }

    // Update distance if provided
    final newDistance =
        distanceDelta != null ? state.distance + distanceDelta : state.distance;

    // Update GPS trace if new position provided
    final updatedGpsPoints =
        newPosition != null
            ? [...state.gpsPoints, newPosition]
            : state.gpsPoints;

    // Update heart rate data
    final updatedHeartRateData =
        heartRate != null
            ? [...state.heartRateData, heartRate]
            : state.heartRateData;

    // Update cadence data
    final updatedCadenceData =
        cadence != null ? [...state.cadenceData, cadence] : state.cadenceData;

    // Update power data
    final updatedPowerData =
        power != null ? [...state.powerData, power] : state.powerData;

    // Update elevation data
    final updatedElevationData =
        elevation != null
            ? [...state.elevationData, elevation]
            : state.elevationData;

    // Calculate current duration
    final now = DateTime.now();
    final elapsedSeconds =
        now.difference(state.startTime).inSeconds - state.totalPauseTime;

    // Calculate current pace (min/km)
    final currentPaceSeconds =
        newDistance > 0 ? elapsedSeconds / newDistance : 0;

    // Calculate elevation gain
    double elevationGain = state.elevationGain;
    if (elevation != null && state.elevationData.isNotEmpty) {
      final lastElevation = state.elevationData.last;
      final elevationDelta = elevation - lastElevation;
      if (elevationDelta > 0) {
        elevationGain += elevationDelta;
      }
    }

    // Calculate calories (very simplified)
    final calories = (elapsedSeconds / 60) * 10; // ~10 calories per minute

    // Calculate averages
    final avgHeartRate =
        updatedHeartRateData.isNotEmpty
            ? updatedHeartRateData.reduce((a, b) => a + b) ~/
                updatedHeartRateData.length
            : null;

    final avgCadence =
        updatedCadenceData.isNotEmpty
            ? updatedCadenceData.reduce((a, b) => a + b) ~/
                updatedCadenceData.length
            : null;

    final avgPower =
        updatedPowerData.isNotEmpty
            ? updatedPowerData.reduce((a, b) => a + b) ~/
                updatedPowerData.length
            : null;

    // Update state
    state = state.copyWith(
      distance: newDistance,
      duration: elapsedSeconds,
      currentPace: currentPaceSeconds.toDouble(),
      avgPace: newDistance > 0 ? elapsedSeconds / newDistance : 0,
      currentHeartRate: heartRate,
      heartRateData: updatedHeartRateData,
      avgHeartRate: avgHeartRate,
      currentCadence: cadence,
      cadenceData: updatedCadenceData,
      avgCadence: avgCadence,
      currentPower: power,
      powerData: updatedPowerData,
      avgPower: avgPower,
      elevation: elevation,
      elevationData: updatedElevationData,
      elevationGain: elevationGain.toDouble(), // Fixed: Convert to double
      gpsPoints: updatedGpsPoints,
      calories: calories.toInt(),
    );
  }

  // Add a lap marker
  void addLap() {
    if (state.status != ActivityStatus.active) {
      return;
    }

    final now = DateTime.now();
    final totalElapsedSeconds =
        now.difference(state.startTime).inSeconds - state.totalPauseTime;
    final previousLapDuration =
        state.laps.isNotEmpty ? state.laps.last.duration : 0;
    final lapDuration = totalElapsedSeconds - previousLapDuration;

    // Calculate lap distance
    final previousLapDistance =
        state.laps.isNotEmpty ? state.laps.last.distance : 0.0;
    final lapDistance = state.distance - previousLapDistance;

    // Calculate lap averages
    final lapHeartRates =
        state.heartRateData
            .skip(state.heartRateData.length - lapDuration)
            .toList();
    final lapCadences =
        state.cadenceData.skip(state.cadenceData.length - lapDuration).toList();
    final lapPowers =
        state.powerData.skip(state.powerData.length - lapDuration).toList();

    final avgLapHeartRate =
        lapHeartRates.isNotEmpty
            ? lapHeartRates.reduce((a, b) => a + b) ~/ lapHeartRates.length
            : null;

    final avgLapCadence =
        lapCadences.isNotEmpty
            ? lapCadences.reduce((a, b) => a + b) ~/ lapCadences.length
            : null;

    final avgLapPower =
        lapPowers.isNotEmpty
            ? lapPowers.reduce((a, b) => a + b) ~/ lapPowers.length
            : null;

    // Create lap data
    final lap = LapData(
      lapNumber: state.laps.length + 1,
      distance: lapDistance,
      duration: lapDuration,
      averageHeartRate: avgLapHeartRate,
      averageCadence: avgLapCadence,
      averagePower: avgLapPower,
    );

    // Add lap to state
    state = state.copyWith(laps: [...state.laps, lap]);
  }
}

class ActivityTrackingState {
  final ActivityStatus status;
  final ActivityType activityType;
  final DateTime startTime;
  final DateTime? pauseTime;
  final int totalPauseTime; // in seconds
  final double distance; // in kilometers
  final int duration; // in seconds (excluding pauses)
  final double currentPace; // seconds per kilometer
  final double avgPace; // seconds per kilometer
  final int? currentHeartRate; // bpm
  final List<int> heartRateData; // bpm
  final int? avgHeartRate; // bpm
  final int? currentCadence; // steps per minute
  final List<int> cadenceData; // steps per minute
  final int? avgCadence; // steps per minute
  final int? currentPower; // watts
  final List<int> powerData; // watts
  final int? avgPower; // watts
  final double? elevation; // meters
  final List<double> elevationData; // meters
  final double elevationGain; // meters
  final List<LatLng> gpsPoints;
  final int calories; // estimated calories burned
  final List<LapData> laps;

  ActivityTrackingState({
    this.status = ActivityStatus.inactive,
    this.activityType = ActivityType.run,
    DateTime? startTime,
    this.pauseTime,
    this.totalPauseTime = 0,
    this.distance = 0.0,
    this.duration = 0,
    this.currentPace = 0.0,
    this.avgPace = 0.0,
    this.currentHeartRate,
    List<int>? heartRateData,
    this.avgHeartRate,
    this.currentCadence,
    List<int>? cadenceData,
    this.avgCadence,
    this.currentPower,
    List<int>? powerData,
    this.avgPower,
    this.elevation,
    List<double>? elevationData,
    this.elevationGain = 0.0,
    List<LatLng>? gpsPoints,
    this.calories = 0,
    List<LapData>? laps,
  }) : startTime = startTime ?? DateTime.now(),
       heartRateData = heartRateData ?? [],
       cadenceData = cadenceData ?? [],
       powerData = powerData ?? [],
       elevationData = elevationData ?? [],
       gpsPoints = gpsPoints ?? [],
       laps = laps ?? [];

  ActivityTrackingState copyWith({
    ActivityStatus? status,
    ActivityType? activityType,
    DateTime? startTime,
    DateTime? pauseTime,
    int? totalPauseTime,
    double? distance,
    int? duration,
    double? currentPace,
    double? avgPace,
    int? currentHeartRate,
    List<int>? heartRateData,
    int? avgHeartRate,
    int? currentCadence,
    List<int>? cadenceData,
    int? avgCadence,
    int? currentPower,
    List<int>? powerData,
    int? avgPower,
    double? elevation,
    List<double>? elevationData,
    double? elevationGain,
    List<LatLng>? gpsPoints,
    int? calories,
    List<LapData>? laps,
  }) {
    return ActivityTrackingState(
      status: status ?? this.status,
      activityType: activityType ?? this.activityType,
      startTime: startTime ?? this.startTime,
      pauseTime: pauseTime,
      totalPauseTime: totalPauseTime ?? this.totalPauseTime,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      currentPace: currentPace ?? this.currentPace,
      avgPace: avgPace ?? this.avgPace,
      currentHeartRate: currentHeartRate,
      heartRateData: heartRateData ?? this.heartRateData,
      avgHeartRate: avgHeartRate ?? this.avgHeartRate,
      currentCadence: currentCadence,
      cadenceData: cadenceData ?? this.cadenceData,
      avgCadence: avgCadence ?? this.avgCadence,
      currentPower: currentPower,
      powerData: powerData ?? this.powerData,
      avgPower: avgPower ?? this.avgPower,
      elevation: elevation,
      elevationData: elevationData ?? this.elevationData,
      elevationGain: elevationGain ?? this.elevationGain,
      gpsPoints: gpsPoints ?? this.gpsPoints,
      calories: calories ?? this.calories,
      laps: laps ?? this.laps,
    );
  }
}

enum ActivityStatus { inactive, active, paused }

class ActivityMetricsState {
  final double distance; // in kilometers
  final int duration; // in seconds
  final double currentPace; // seconds per kilometer
  final double avgPace; // seconds per kilometer
  final int? currentHeartRate; // bpm
  final int? avgHeartRate; // bpm
  final int? currentCadence; // steps per minute
  final int? avgCadence; // steps per minute
  final int? currentPower; // watts
  final int? avgPower; // watts
  final double? elevation; // meters
  final double elevationGain; // meters
  final int calories; // estimated calories burned

  ActivityMetricsState({
    required this.distance,
    required this.duration,
    required this.currentPace,
    required this.avgPace,
    this.currentHeartRate,
    this.avgHeartRate,
    this.currentCadence,
    this.avgCadence,
    this.currentPower,
    this.avgPower,
    this.elevation,
    required this.elevationGain,
    required this.calories,
  });

  factory ActivityMetricsState.empty() {
    return ActivityMetricsState(
      distance: 0.0,
      duration: 0,
      currentPace: 0.0,
      avgPace: 0.0,
      elevationGain: 0.0,
      calories: 0,
    );
  }

  // Format pace as MM:SS
  String get formattedPace {
    if (avgPace <= 0) return '--:--';

    final minutes = (avgPace / 60).floor();
    final seconds = (avgPace % 60).floor();

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Format duration as HH:MM:SS
  String get formattedDuration {
    final hours = (duration / 3600).floor();
    final minutes = ((duration % 3600) / 60).floor();
    final seconds = (duration % 60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }
}

// Generate some sample activities for testing
List<ActivityModel> _generateSampleActivities() {
  return [
    ActivityModel(
      id: '1',
      userId: 'user-1',
      title: 'Morning Run',
      type: ActivityType.run,
      startTime: DateTime.now().subtract(const Duration(days: 0, hours: 8)),
      duration: 1725, // 28:45
      distance: 5.2,
      routeId: 'route-1',
      gpsTrace: [
        const LatLng(40.7128, -74.0060),
        const LatLng(40.7129, -74.0065),
        // More points would be here
      ],
      isPublic: true,
      metrics: ActivityMetrics(
        heartRateData: List.generate(30, (index) => 140 + (index % 10)),
        cadenceData: List.generate(30, (index) => 170 + (index % 6)),
        elevationData: List.generate(30, (index) => 50.0 + (index % 5)),
        averageHeartRate: 148,
        maxHeartRate: 165,
        averageCadence: 172,
        maxCadence: 178,
        caloriesBurned: 234,
      ),
      laps: [
        LapData(
          lapNumber: 1,
          distance: 1.0,
          duration: 330, // 5:30
          averageHeartRate: 145,
          averageCadence: 170,
        ),
        LapData(
          lapNumber: 2,
          distance: 1.0,
          duration: 335, // 5:35
          averageHeartRate: 148,
          averageCadence: 172,
        ),
        // More laps would be here
      ],
      likedByUserIds: ['user-2', 'user-3'],
      comments: [
        CommentModel(
          id: 'comment-1',
          userId: 'user-2',
          userName: 'Sarah',
          content: 'Great pace!',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
    ),
    ActivityModel(
      id: '2',
      userId: 'user-1',
      title: 'Interval Training',
      type: ActivityType.run,
      startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      duration: 1335, // 22:15
      distance: 3.8,
      routeId: 'route-2',
      gpsTrace: [
        const LatLng(40.7128, -74.0060),
        const LatLng(40.7130, -74.0070),
        // More points would be here
      ],
      isPublic: true,
      metrics: ActivityMetrics(
        heartRateData: List.generate(30, (index) => 150 + (index % 15)),
        cadenceData: List.generate(30, (index) => 175 + (index % 8)),
        elevationData: List.generate(30, (index) => 30.0 + (index % 3)),
        averageHeartRate: 160,
        maxHeartRate: 178,
        averageCadence: 178,
        maxCadence: 185,
        caloriesBurned: 220,
      ),
      laps: [
        LapData(
          lapNumber: 1,
          distance: 0.4,
          duration: 75, // 1:15 (fast)
          averageHeartRate: 170,
          averageCadence: 182,
        ),
        LapData(
          lapNumber: 2,
          distance: 0.4,
          duration: 120, // 2:00 (recovery)
          averageHeartRate: 150,
          averageCadence: 172,
        ),
        // More laps would be here
      ],
      likedByUserIds: ['user-3'],
      comments: [],
    ),
    ActivityModel(
      id: '3',
      userId: 'user-1',
      title: 'Long Run',
      type: ActivityType.run,
      startTime: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      duration: 2850, // 47:30
      distance: 8.1,
      routeId: 'route-3',
      gpsTrace: [
        const LatLng(40.7128, -74.0060),
        const LatLng(40.7135, -74.0080),
        // More points would be here
      ],
      isPublic: true,
      metrics: ActivityMetrics(
        heartRateData: List.generate(30, (index) => 135 + (index % 8)),
        cadenceData: List.generate(30, (index) => 168 + (index % 5)),
        elevationData: List.generate(30, (index) => 40.0 + (index % 10)),
        averageHeartRate: 142,
        maxHeartRate: 155,
        averageCadence: 170,
        maxCadence: 175,
        caloriesBurned: 480,
      ),
      laps: [
        LapData(
          lapNumber: 1,
          distance: 1.0,
          duration: 352, // 5:52
          averageHeartRate: 140,
          averageCadence: 168,
        ),
        LapData(
          lapNumber: 2,
          distance: 1.0,
          duration: 349, // 5:49
          averageHeartRate: 142,
          averageCadence: 170,
        ),
        // More laps would be here
      ],
      likedByUserIds: ['user-2', 'user-4'],
      comments: [
        CommentModel(
          id: 'comment-2',
          userId: 'user-4',
          userName: 'Mike',
          content: 'Nice long run!',
          timestamp: DateTime.now().subtract(
            const Duration(days: 1, hours: 12),
          ),
        ),
      ],
    ),
  ];
}
