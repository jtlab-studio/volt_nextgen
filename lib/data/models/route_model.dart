import 'package:latlong2/latlong.dart';

enum RouteDifficulty {
  easy,
  moderate,
  hard,
}

extension RouteDifficultyExtension on RouteDifficulty {
  String get displayName {
    switch (this) {
      case RouteDifficulty.easy:
        return 'Easy';
      case RouteDifficulty.moderate:
        return 'Moderate';
      case RouteDifficulty.hard:
        return 'Hard';
    }
  }
}

enum RoutePrivacy {
  public,
  friendsOnly,
  private,
}

extension RoutePrivacyExtension on RoutePrivacy {
  String get displayName {
    switch (this) {
      case RoutePrivacy.public:
        return 'Public';
      case RoutePrivacy.friendsOnly:
        return 'Friends Only';
      case RoutePrivacy.private:
        return 'Private';
    }
  }
}

class RouteModel {
  final String id;
  final String name;
  final String creatorId;
  final String? description;
  final List<LatLng> waypoints;
  final double distance; // kilometers
  final double elevationGain; // meters
  final double elevationLoss; // meters
  final RouteDifficulty difficulty;
  final RoutePrivacy privacy;
  final List<String> tags;
  final String? surfaceType;
  final int? estimatedDuration; // seconds
  final RouteMetadata metadata;
  final List<String> favoriteByUserIds;

  RouteModel({
    required this.id,
    required this.name,
    required this.creatorId,
    this.description,
    required this.waypoints,
    required this.distance,
    required this.elevationGain,
    required this.elevationLoss,
    required this.difficulty,
    required this.privacy,
    required this.tags,
    this.surfaceType,
    this.estimatedDuration,
    required this.metadata,
    required this.favoriteByUserIds,
  });

  // Estimated time formatted as HH:MM
  String get estimatedTime {
    if (estimatedDuration == null) return '--:--';
    
    final hours = (estimatedDuration! / 3600).floor();
    final minutes = ((estimatedDuration! % 3600) / 60).floor();
    
    return '${hours > 0 ? '$hours:' : ''}${minutes.toString().padLeft(2, '0')} min';
  }

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      creatorId: json['creatorId'] as String,
      description: json['description'] as String?,
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => LatLng(
                (e as Map<String, dynamic>)['latitude'] as double,
                (e as Map<String, dynamic>)['longitude'] as double,
              ))
          .toList(),
      distance: json['distance'] as double,
      elevationGain: json['elevationGain'] as double,
      elevationLoss: json['elevationLoss'] as double,
      difficulty: RouteDifficulty.values[json['difficulty'] as int],
      privacy: RoutePrivacy.values[json['privacy'] as int],
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      surfaceType: json['surfaceType'] as String?,
      estimatedDuration: json['estimatedDuration'] as int?,
      metadata: RouteMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      favoriteByUserIds: (json['favoriteByUserIds'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'creatorId': creatorId,
      'description': description,
      'waypoints': waypoints
          .map((e) => {
                'latitude': e.latitude,
                'longitude': e.longitude,
              })
          .toList(),
      'distance': distance,
      'elevationGain': elevationGain,
      'elevationLoss': elevationLoss,
      'difficulty': difficulty.index,
      'privacy': privacy.index,
      'tags': tags,
      'surfaceType': surfaceType,
      'estimatedDuration': estimatedDuration,
      'metadata': metadata.toJson(),
      'favoriteByUserIds': favoriteByUserIds,
    };
  }

  RouteModel copyWith({
    String? id,
    String? name,
    String? creatorId,
    String? description,
    List<LatLng>? waypoints,
    double? distance,
    double? elevationGain,
    double? elevationLoss,
    RouteDifficulty? difficulty,
    RoutePrivacy? privacy,
    List<String>? tags,
    String? surfaceType,
    int? estimatedDuration,
    RouteMetadata? metadata,
    List<String>? favoriteByUserIds,
  }) {
    return RouteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      creatorId: creatorId ?? this.creatorId,
      description: description ?? this.description,
      waypoints: waypoints ?? this.waypoints,
      distance: distance ?? this.distance,
      elevationGain: elevationGain ?? this.elevationGain,
      elevationLoss: elevationLoss ?? this.elevationLoss,
      difficulty: difficulty ?? this.difficulty,
      privacy: privacy ?? this.privacy,
      tags: tags ?? this.tags,
      surfaceType: surfaceType ?? this.surfaceType,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      metadata: metadata ?? this.metadata,
      favoriteByUserIds: favoriteByUserIds ?? this.favoriteByUserIds,
    );
  }
}

class RouteMetadata {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String trafficLevel; // Light, Moderate, Heavy
  final String safetyRating; // Low, Medium, High
  final String recommendedTimeOfDay; // Morning, Afternoon, Evening
  final List<ElevationPoint> elevationProfile;
  final int completionCount;
  final FastestTime? fastestTime;

  RouteMetadata({
    required this.createdAt,
    this.updatedAt,
    required this.trafficLevel,
    required this.safetyRating,
    required this.recommendedTimeOfDay,
    required this.elevationProfile,
    required this.completionCount,
    this.fastestTime,
  });

  factory RouteMetadata.fromJson(Map<String, dynamic> json) {
    return RouteMetadata(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      trafficLevel: json['trafficLevel'] as String,
      safetyRating: json['safetyRating'] as String,
      recommendedTimeOfDay: json['recommendedTimeOfDay'] as String,
      elevationProfile: (json['elevationProfile'] as List<dynamic>)
          .map((e) => ElevationPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      completionCount: json['completionCount'] as int,
      fastestTime: json['fastestTime'] != null
          ? FastestTime.fromJson(json['fastestTime'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'trafficLevel': trafficLevel,
      'safetyRating': safetyRating,
      'recommendedTimeOfDay': recommendedTimeOfDay,
      'elevationProfile': elevationProfile.map((e) => e.toJson()).toList(),
      'completionCount': completionCount,
      'fastestTime': fastestTime?.toJson(),
    };
  }

  RouteMetadata copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? trafficLevel,
    String? safetyRating,
    String? recommendedTimeOfDay,
    List<ElevationPoint>? elevationProfile,
    int? completionCount,
    FastestTime? fastestTime,
  }) {
    return RouteMetadata(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      trafficLevel: trafficLevel ?? this.trafficLevel,
      safetyRating: safetyRating ?? this.safetyRating,
      recommendedTimeOfDay: recommendedTimeOfDay ?? this.recommendedTimeOfDay,
      elevationProfile: elevationProfile ?? this.elevationProfile,
      completionCount: completionCount ?? this.completionCount,
      fastestTime: fastestTime ?? this.fastestTime,
    );
  }
}

class ElevationPoint {
  final double distance; // kilometers from start
  final double elevation; // meters

  ElevationPoint({
    required this.distance,
    required this.elevation,
  });

  factory ElevationPoint.fromJson(Map<String, dynamic> json) {
    return ElevationPoint(
      distance: json['distance'] as double,
      elevation: json['elevation'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'elevation': elevation,
    };
  }
}

class FastestTime {
  final String userId;
  final String userName;
  final int duration; // seconds
  final DateTime date;

  FastestTime({
    required this.userId,
    required this.userName,
    required this.duration,
    required this.date,
  });

  // Format duration as MM:SS
  String get formattedTime {
    final minutes = (duration / 60).floor();
    final seconds = (duration % 60).floor();
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  factory FastestTime.fromJson(Map<String, dynamic> json) {
    return FastestTime(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      duration: json['duration'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  FastestTime copyWith({
    String? userId,
    String? userName,
    int? duration,
    DateTime? date,
  }) {
    return FastestTime(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      duration: duration ?? this.duration,
      date: date ?? this.date,
    );
  }
}
