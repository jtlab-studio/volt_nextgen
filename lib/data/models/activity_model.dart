import 'package:latlong2/latlong.dart';

enum ActivityType {
  run,
  walk,
  bike,
  hike,
  other,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
      case ActivityType.run:
        return 'Run';
      case ActivityType.walk:
        return 'Walk';
      case ActivityType.bike:
        return 'Bike';
      case ActivityType.hike:
        return 'Hike';
      case ActivityType.other:
        return 'Other';
    }
  }
}

class ActivityModel {
  final String id;
  final String userId;
  final String title;
  final ActivityType type;
  final DateTime startTime;
  final int duration; // in seconds
  final double distance; // in kilometers
  final String? routeId;
  final List<LatLng> gpsTrace;
  final bool isPublic;
  final ActivityMetrics metrics;
  final List<LapData> laps;
  final List<String> likedByUserIds;
  final List<CommentModel> comments;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.startTime,
    required this.duration,
    required this.distance,
    this.routeId,
    required this.gpsTrace,
    required this.isPublic,
    required this.metrics,
    required this.laps,
    required this.likedByUserIds,
    required this.comments,
  });

  String get pace {
    if (distance <= 0) return '--:--';
    
    final paceSeconds = duration / distance;
    final minutes = (paceSeconds / 60).floor();
    final seconds = (paceSeconds % 60).floor();
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Returns elevation gain in meters
  double get elevationGain {
    double gain = 0;
    
    for (int i = 1; i < metrics.elevationData.length; i++) {
      final diff = metrics.elevationData[i] - metrics.elevationData[i - 1];
      if (diff > 0) {
        gain += diff;
      }
    }
    
    return gain;
  }

  // Returns elevation loss in meters
  double get elevationLoss {
    double loss = 0;
    
    for (int i = 1; i < metrics.elevationData.length; i++) {
      final diff = metrics.elevationData[i - 1] - metrics.elevationData[i];
      if (diff > 0) {
        loss += diff;
      }
    }
    
    return loss;
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      type: ActivityType.values[json['type'] as int],
      startTime: DateTime.parse(json['startTime'] as String),
      duration: json['duration'] as int,
      distance: json['distance'] as double,
      routeId: json['routeId'] as String?,
      gpsTrace: (json['gpsTrace'] as List<dynamic>)
          .map((e) => LatLng(
                (e as Map<String, dynamic>)['latitude'] as double,
                (e as Map<String, dynamic>)['longitude'] as double,
              ))
          .toList(),
      isPublic: json['isPublic'] as bool,
      metrics: ActivityMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      laps: (json['laps'] as List<dynamic>)
          .map((e) => LapData.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedByUserIds: (json['likedByUserIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'type': type.index,
      'startTime': startTime.toIso8601String(),
      'duration': duration,
      'distance': distance,
      'routeId': routeId,
      'gpsTrace': gpsTrace
          .map((e) => {
                'latitude': e.latitude,
                'longitude': e.longitude,
              })
          .toList(),
      'isPublic': isPublic,
      'metrics': metrics.toJson(),
      'laps': laps.map((e) => e.toJson()).toList(),
      'likedByUserIds': likedByUserIds,
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }

  ActivityModel copyWith({
    String? id,
    String? userId,
    String? title,
    ActivityType? type,
    DateTime? startTime,
    int? duration,
    double? distance,
    String? routeId,
    List<LatLng>? gpsTrace,
    bool? isPublic,
    ActivityMetrics? metrics,
    List<LapData>? laps,
    List<String>? likedByUserIds,
    List<CommentModel>? comments,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      routeId: routeId ?? this.routeId,
      gpsTrace: gpsTrace ?? this.gpsTrace,
      isPublic: isPublic ?? this.isPublic,
      metrics: metrics ?? this.metrics,
      laps: laps ?? this.laps,
      likedByUserIds: likedByUserIds ?? this.likedByUserIds,
      comments: comments ?? this.comments,
    );
  }
}

class ActivityMetrics {
  final List<int> heartRateData; // beats per minute
  final List<int> cadenceData; // steps per minute
  final List<double> elevationData; // meters
  final List<int>? powerData; // watts
  final int? averageHeartRate;
  final int? maxHeartRate;
  final int? averageCadence;
  final int? maxCadence;
  final int? averagePower;
  final int? maxPower;
  final int caloriesBurned;

  ActivityMetrics({
    required this.heartRateData,
    required this.cadenceData,
    required this.elevationData,
    this.powerData,
    this.averageHeartRate,
    this.maxHeartRate,
    this.averageCadence,
    this.maxCadence,
    this.averagePower,
    this.maxPower,
    required this.caloriesBurned,
  });

  factory ActivityMetrics.fromJson(Map<String, dynamic> json) {
    return ActivityMetrics(
      heartRateData: (json['heartRateData'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      cadenceData: (json['cadenceData'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      elevationData: (json['elevationData'] as List<dynamic>)
          .map((e) => e as double)
          .toList(),
      powerData: json['powerData'] != null
          ? (json['powerData'] as List<dynamic>)
              .map((e) => e as int)
              .toList()
          : null,
      averageHeartRate: json['averageHeartRate'] as int?,
      maxHeartRate: json['maxHeartRate'] as int?,
      averageCadence: json['averageCadence'] as int?,
      maxCadence: json['maxCadence'] as int?,
      averagePower: json['averagePower'] as int?,
      maxPower: json['maxPower'] as int?,
      caloriesBurned: json['caloriesBurned'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heartRateData': heartRateData,
      'cadenceData': cadenceData,
      'elevationData': elevationData,
      'powerData': powerData,
      'averageHeartRate': averageHeartRate,
      'maxHeartRate': maxHeartRate,
      'averageCadence': averageCadence,
      'maxCadence': maxCadence,
      'averagePower': averagePower,
      'maxPower': maxPower,
      'caloriesBurned': caloriesBurned,
    };
  }

  ActivityMetrics copyWith({
    List<int>? heartRateData,
    List<int>? cadenceData,
    List<double>? elevationData,
    List<int>? powerData,
    int? averageHeartRate,
    int? maxHeartRate,
    int? averageCadence,
    int? maxCadence,
    int? averagePower,
    int? maxPower,
    int? caloriesBurned,
  }) {
    return ActivityMetrics(
      heartRateData: heartRateData ?? this.heartRateData,
      cadenceData: cadenceData ?? this.cadenceData,
      elevationData: elevationData ?? this.elevationData,
      powerData: powerData ?? this.powerData,
      averageHeartRate: averageHeartRate ?? this.averageHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      averageCadence: averageCadence ?? this.averageCadence,
      maxCadence: maxCadence ?? this.maxCadence,
      averagePower: averagePower ?? this.averagePower,
      maxPower: maxPower ?? this.maxPower,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
    );
  }
}

class LapData {
  final int lapNumber;
  final double distance; // kilometers
  final int duration; // seconds
  final int? averageHeartRate;
  final int? averagePower;
  final int? averageCadence;

  LapData({
    required this.lapNumber,
    required this.distance,
    required this.duration,
    this.averageHeartRate,
    this.averagePower,
    this.averageCadence,
  });

  String get pace {
    if (distance <= 0) return '--:--';
    
    final paceSeconds = duration / distance;
    final minutes = (paceSeconds / 60).floor();
    final seconds = (paceSeconds % 60).floor();
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  factory LapData.fromJson(Map<String, dynamic> json) {
    return LapData(
      lapNumber: json['lapNumber'] as int,
      distance: json['distance'] as double,
      duration: json['duration'] as int,
      averageHeartRate: json['averageHeartRate'] as int?,
      averagePower: json['averagePower'] as int?,
      averageCadence: json['averageCadence'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lapNumber': lapNumber,
      'distance': distance,
      'duration': duration,
      'averageHeartRate': averageHeartRate,
      'averagePower': averagePower,
      'averageCadence': averageCadence,
    };
  }

  LapData copyWith({
    int? lapNumber,
    double? distance,
    int? duration,
    int? averageHeartRate,
    int? averagePower,
    int? averageCadence,
  }) {
    return LapData(
      lapNumber: lapNumber ?? this.lapNumber,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      averageHeartRate: averageHeartRate ?? this.averageHeartRate,
      averagePower: averagePower ?? this.averagePower,
      averageCadence: averageCadence ?? this.averageCadence,
    );
  }
}

class CommentModel {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  CommentModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? timestamp,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
