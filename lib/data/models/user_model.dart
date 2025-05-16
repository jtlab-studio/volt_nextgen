import 'package:volt_nextgen/core/constants/social_tier.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final SocialTier tier;
  final UserStats stats;
  final List<String> communityIds;
  final Settings settings;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.tier,
    required this.stats,
    required this.communityIds,
    required this.settings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      tier: SocialTier.values[json['tier'] as int],
      stats: UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      communityIds: (json['communityIds'] as List<dynamic>).map((e) => e as String).toList(),
      settings: Settings.fromJson(json['settings'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'tier': tier.index,
      'stats': stats.toJson(),
      'communityIds': communityIds,
      'settings': settings.toJson(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    SocialTier? tier,
    UserStats? stats,
    List<String>? communityIds,
    Settings? settings,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      tier: tier ?? this.tier,
      stats: stats ?? this.stats,
      communityIds: communityIds ?? this.communityIds,
      settings: settings ?? this.settings,
    );
  }
}

class UserStats {
  final int totalActivities;
  final double totalDistance; // in km
  final int totalDuration; // in seconds
  final int currentStreak;
  final int bestStreak;

  UserStats({
    required this.totalActivities,
    required this.totalDistance,
    required this.totalDuration,
    required this.currentStreak,
    required this.bestStreak,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalActivities: json['totalActivities'] as int,
      totalDistance: json['totalDistance'] as double,
      totalDuration: json['totalDuration'] as int,
      currentStreak: json['currentStreak'] as int,
      bestStreak: json['bestStreak'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalActivities': totalActivities,
      'totalDistance': totalDistance,
      'totalDuration': totalDuration,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
    };
  }

  UserStats copyWith({
    int? totalActivities,
    double? totalDistance,
    int? totalDuration,
    int? currentStreak,
    int? bestStreak,
  }) {
    return UserStats(
      totalActivities: totalActivities ?? this.totalActivities,
      totalDistance: totalDistance ?? this.totalDistance,
      totalDuration: totalDuration ?? this.totalDuration,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
    );
  }
}

class Settings {
  final bool darkMode;
  final bool metricUnits;
  final ThresholdSettings thresholds;
  final NotificationSettings notifications;

  Settings({
    required this.darkMode,
    required this.metricUnits,
    required this.thresholds,
    required this.notifications,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      darkMode: json['darkMode'] as bool,
      metricUnits: json['metricUnits'] as bool,
      thresholds: ThresholdSettings.fromJson(json['thresholds'] as Map<String, dynamic>),
      notifications: NotificationSettings.fromJson(json['notifications'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'darkMode': darkMode,
      'metricUnits': metricUnits,
      'thresholds': thresholds.toJson(),
      'notifications': notifications.toJson(),
    };
  }

  Settings copyWith({
    bool? darkMode,
    bool? metricUnits,
    ThresholdSettings? thresholds,
    NotificationSettings? notifications,
  }) {
    return Settings(
      darkMode: darkMode ?? this.darkMode,
      metricUnits: metricUnits ?? this.metricUnits,
      thresholds: thresholds ?? this.thresholds,
      notifications: notifications ?? this.notifications,
    );
  }
}

class ThresholdSettings {
  final int lthr; // Lactate threshold heart rate
  final int criticalPower; // FTP or critical power
  final String thresholdPace; // Format: "5:30" (min:sec per km)

  ThresholdSettings({
    required this.lthr,
    required this.criticalPower,
    required this.thresholdPace,
  });

  factory ThresholdSettings.fromJson(Map<String, dynamic> json) {
    return ThresholdSettings(
      lthr: json['lthr'] as int,
      criticalPower: json['criticalPower'] as int,
      thresholdPace: json['thresholdPace'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lthr': lthr,
      'criticalPower': criticalPower,
      'thresholdPace': thresholdPace,
    };
  }

  ThresholdSettings copyWith({
    int? lthr,
    int? criticalPower,
    String? thresholdPace,
  }) {
    return ThresholdSettings(
      lthr: lthr ?? this.lthr,
      criticalPower: criticalPower ?? this.criticalPower,
      thresholdPace: thresholdPace ?? this.thresholdPace,
    );
  }
}

class NotificationSettings {
  final bool activityReminders;
  final bool socialNotifications;
  final bool goalAlerts;

  NotificationSettings({
    required this.activityReminders,
    required this.socialNotifications,
    required this.goalAlerts,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      activityReminders: json['activityReminders'] as bool,
      socialNotifications: json['socialNotifications'] as bool,
      goalAlerts: json['goalAlerts'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityReminders': activityReminders,
      'socialNotifications': socialNotifications,
      'goalAlerts': goalAlerts,
    };
  }

  NotificationSettings copyWith({
    bool? activityReminders,
    bool? socialNotifications,
    bool? goalAlerts,
  }) {
    return NotificationSettings(
      activityReminders: activityReminders ?? this.activityReminders,
      socialNotifications: socialNotifications ?? this.socialNotifications,
      goalAlerts: goalAlerts ?? this.goalAlerts,
    );
  }
}
