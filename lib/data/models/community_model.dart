import 'package:volt_nextgen/core/constants/social_tier.dart';

enum MemberRole {
  member,
  coach,
  admin,
}

extension MemberRoleExtension on MemberRole {
  String get displayName {
    switch (this) {
      case MemberRole.member:
        return 'Member';
      case MemberRole.coach:
        return 'Coach';
      case MemberRole.admin:
        return 'Admin';
    }
  }
}

class CommunityModel {
  final String id;
  final String name;
  final String? description;
  final SocialTier tier;
  final CommunityStatistics statistics;
  final List<CommunityMember> members;
  final List<CommunityEvent> events;
  final List<CommunityChallenge> challenges;
  final CommunityHealthMetrics healthMetrics;

  CommunityModel({
    required this.id,
    required this.name,
    this.description,
    required this.tier,
    required this.statistics,
    required this.members,
    required this.events,
    required this.challenges,
    required this.healthMetrics,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      tier: SocialTier.values[json['tier'] as int],
      statistics: CommunityStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => CommunityMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>)
          .map((e) => CommunityEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      challenges: (json['challenges'] as List<dynamic>)
          .map((e) => CommunityChallenge.fromJson(e as Map<String, dynamic>))
          .toList(),
      healthMetrics: CommunityHealthMetrics.fromJson(json['healthMetrics'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tier': tier.index,
      'statistics': statistics.toJson(),
      'members': members.map((e) => e.toJson()).toList(),
      'events': events.map((e) => e.toJson()).toList(),
      'challenges': challenges.map((e) => e.toJson()).toList(),
      'healthMetrics': healthMetrics.toJson(),
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    String? description,
    SocialTier? tier,
    CommunityStatistics? statistics,
    List<CommunityMember>? members,
    List<CommunityEvent>? events,
    List<CommunityChallenge>? challenges,
    CommunityHealthMetrics? healthMetrics,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      tier: tier ?? this.tier,
      statistics: statistics ?? this.statistics,
      members: members ?? this.members,
      events: events ?? this.events,
      challenges: challenges ?? this.challenges,
      healthMetrics: healthMetrics ?? this.healthMetrics,
    );
  }
}

class CommunityStatistics {
  final int totalActivities;
  final double totalDistance; // kilometers
  final int totalDuration; // seconds
  final int activeMembers; // active in last 30 days
  final double weeklyDistance; // kilometers
  final int weeklyActivities;

  CommunityStatistics({
    required this.totalActivities,
    required this.totalDistance,
    required this.totalDuration,
    required this.activeMembers,
    required this.weeklyDistance,
    required this.weeklyActivities,
  });

  factory CommunityStatistics.fromJson(Map<String, dynamic> json) {
    return CommunityStatistics(
      totalActivities: json['totalActivities'] as int,
      totalDistance: json['totalDistance'] as double,
      totalDuration: json['totalDuration'] as int,
      activeMembers: json['activeMembers'] as int,
      weeklyDistance: json['weeklyDistance'] as double,
      weeklyActivities: json['weeklyActivities'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalActivities': totalActivities,
      'totalDistance': totalDistance,
      'totalDuration': totalDuration,
      'activeMembers': activeMembers,
      'weeklyDistance': weeklyDistance,
      'weeklyActivities': weeklyActivities,
    };
  }

  CommunityStatistics copyWith({
    int? totalActivities,
    double? totalDistance,
    int? totalDuration,
    int? activeMembers,
    double? weeklyDistance,
    int? weeklyActivities,
  }) {
    return CommunityStatistics(
      totalActivities: totalActivities ?? this.totalActivities,
      totalDistance: totalDistance ?? this.totalDistance,
      totalDuration: totalDuration ?? this.totalDuration,
      activeMembers: activeMembers ?? this.activeMembers,
      weeklyDistance: weeklyDistance ?? this.weeklyDistance,
      weeklyActivities: weeklyActivities ?? this.weeklyActivities,
    );
  }
}

class CommunityMember {
  final String id;
  final String userId;
  final String name;
  final String? profileImageUrl;
  final MemberRole role;
  final DateTime joinedDate;
  final MemberStatistics statistics;

  CommunityMember({
    required this.id,
    required this.userId,
    required this.name,
    this.profileImageUrl,
    required this.role,
    required this.joinedDate,
    required this.statistics,
  });

  factory CommunityMember.fromJson(Map<String, dynamic> json) {
    return CommunityMember(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      role: MemberRole.values[json['role'] as int],
      joinedDate: DateTime.parse(json['joinedDate'] as String),
      statistics: MemberStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'role': role.index,
      'joinedDate': joinedDate.toIso8601String(),
      'statistics': statistics.toJson(),
    };
  }

  CommunityMember copyWith({
    String? id,
    String? userId,
    String? name,
    String? profileImageUrl,
    MemberRole? role,
    DateTime? joinedDate,
    MemberStatistics? statistics,
  }) {
    return CommunityMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      joinedDate: joinedDate ?? this.joinedDate,
      statistics: statistics ?? this.statistics,
    );
  }
}

class MemberStatistics {
  final int totalActivities;
  final double totalDistance; // kilometers
  final int activeDays;
  final double weeklyDistance; // kilometers
  final int weeklyActivities;
  final bool isActive; // active in last 7 days

  MemberStatistics({
    required this.totalActivities,
    required this.totalDistance,
    required this.activeDays,
    required this.weeklyDistance,
    required this.weeklyActivities,
    required this.isActive,
  });

  factory MemberStatistics.fromJson(Map<String, dynamic> json) {
    return MemberStatistics(
      totalActivities: json['totalActivities'] as int,
      totalDistance: json['totalDistance'] as double,
      activeDays: json['activeDays'] as int,
      weeklyDistance: json['weeklyDistance'] as double,
      weeklyActivities: json['weeklyActivities'] as int,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalActivities': totalActivities,
      'totalDistance': totalDistance,
      'activeDays': activeDays,
      'weeklyDistance': weeklyDistance,
      'weeklyActivities': weeklyActivities,
      'isActive': isActive,
    };
  }

  MemberStatistics copyWith({
    int? totalActivities,
    double? totalDistance,
    int? activeDays,
    double? weeklyDistance,
    int? weeklyActivities,
    bool? isActive,
  }) {
    return MemberStatistics(
      totalActivities: totalActivities ?? this.totalActivities,
      totalDistance: totalDistance ?? this.totalDistance,
      activeDays: activeDays ?? this.activeDays,
      weeklyDistance: weeklyDistance ?? this.weeklyDistance,
      weeklyActivities: weeklyActivities ?? this.weeklyActivities,
      isActive: isActive ?? this.isActive,
    );
  }
}

class CommunityEvent {
  final String id;
  final String name;
  final String? description;
  final DateTime startTime;
  final String location;
  final String creatorId;
  final List<String> participantIds;
  final List<String> goingUserIds;
  final List<String> maybeUserIds;

  CommunityEvent({
    required this.id,
    required this.name,
    this.description,
    required this.startTime,
    required this.location,
    required this.creatorId,
    required this.participantIds,
    required this.goingUserIds,
    required this.maybeUserIds,
  });

  factory CommunityEvent.fromJson(Map<String, dynamic> json) {
    return CommunityEvent(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      location: json['location'] as String,
      creatorId: json['creatorId'] as String,
      participantIds: (json['participantIds'] as List<dynamic>).map((e) => e as String).toList(),
      goingUserIds: (json['goingUserIds'] as List<dynamic>).map((e) => e as String).toList(),
      maybeUserIds: (json['maybeUserIds'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'location': location,
      'creatorId': creatorId,
      'participantIds': participantIds,
      'goingUserIds': goingUserIds,
      'maybeUserIds': maybeUserIds,
    };
  }

  CommunityEvent copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    String? location,
    String? creatorId,
    List<String>? participantIds,
    List<String>? goingUserIds,
    List<String>? maybeUserIds,
  }) {
    return CommunityEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      location: location ?? this.location,
      creatorId: creatorId ?? this.creatorId,
      participantIds: participantIds ?? this.participantIds,
      goingUserIds: goingUserIds ?? this.goingUserIds,
      maybeUserIds: maybeUserIds ?? this.maybeUserIds,
    );
  }
}

class CommunityChallenge {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final ChallengeType type;
  final dynamic target; // could be distance (double), count (int), etc.
  final String? reward;
  final List<ChallengeParticipant> participants;
  final bool isActive;

  CommunityChallenge({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.target,
    this.reward,
    required this.participants,
    required this.isActive,
  });

  factory CommunityChallenge.fromJson(Map<String, dynamic> json) {
    return CommunityChallenge(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: ChallengeType.values[json['type'] as int],
      target: json['target'],
      reward: json['reward'] as String?,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => ChallengeParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'type': type.index,
      'target': target,
      'reward': reward,
      'participants': participants.map((e) => e.toJson()).toList(),
      'isActive': isActive,
    };
  }

  CommunityChallenge copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    ChallengeType? type,
    dynamic target,
    String? reward,
    List<ChallengeParticipant>? participants,
    bool? isActive,
  }) {
    return CommunityChallenge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      target: target ?? this.target,
      reward: reward ?? this.reward,
      participants: participants ?? this.participants,
      isActive: isActive ?? this.isActive,
    );
  }
}

enum ChallengeType {
  distance,
  count,
  elevation,
  streak,
  time,
}

extension ChallengeTypeExtension on ChallengeType {
  String get displayName {
    switch (this) {
      case ChallengeType.distance:
        return 'Distance Challenge';
      case ChallengeType.count:
        return 'Activity Count Challenge';
      case ChallengeType.elevation:
        return 'Elevation Challenge';
      case ChallengeType.streak:
        return 'Streak Challenge';
      case ChallengeType.time:
        return 'Time Challenge';
    }
  }
}

class ChallengeParticipant {
  final String userId;
  final String userName;
  final dynamic progress; // same type as target
  final DateTime joinedDate;

  ChallengeParticipant({
    required this.userId,
    required this.userName,
    required this.progress,
    required this.joinedDate,
  });

  factory ChallengeParticipant.fromJson(Map<String, dynamic> json) {
    return ChallengeParticipant(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      progress: json['progress'],
      joinedDate: DateTime.parse(json['joinedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'progress': progress,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }

  ChallengeParticipant copyWith({
    String? userId,
    String? userName,
    dynamic progress,
    DateTime? joinedDate,
  }) {
    return ChallengeParticipant(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      progress: progress ?? this.progress,
      joinedDate: joinedDate ?? this.joinedDate,
    );
  }
}

class CommunityHealthMetrics {
  final double activityRate; // 0.0 to 1.0
  final double retentionRate; // 0.0 to 1.0
  final double engagementRate; // 0.0 to 1.0
  final double growthRate; // can be negative
  final String healthStatus; // Excellent, Good, At Risk, Probation
  final List<TierRequirementProgress> tierRequirements;
  final String? probationReason;
  final DateTime? probationEndDate;

  CommunityHealthMetrics({
    required this.activityRate,
    required this.retentionRate,
    required this.engagementRate,
    required this.growthRate,
    required this.healthStatus,
    required this.tierRequirements,
    this.probationReason,
    this.probationEndDate,
  });

  factory CommunityHealthMetrics.fromJson(Map<String, dynamic> json) {
    return CommunityHealthMetrics(
      activityRate: json['activityRate'] as double,
      retentionRate: json['retentionRate'] as double,
      engagementRate: json['engagementRate'] as double,
      growthRate: json['growthRate'] as double,
      healthStatus: json['healthStatus'] as String,
      tierRequirements: (json['tierRequirements'] as List<dynamic>)
          .map((e) => TierRequirementProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      probationReason: json['probationReason'] as String?,
      probationEndDate: json['probationEndDate'] != null
          ? DateTime.parse(json['probationEndDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityRate': activityRate,
      'retentionRate': retentionRate,
      'engagementRate': engagementRate,
      'growthRate': growthRate,
      'healthStatus': healthStatus,
      'tierRequirements': tierRequirements.map((e) => e.toJson()).toList(),
      'probationReason': probationReason,
      'probationEndDate': probationEndDate?.toIso8601String(),
    };
  }

  CommunityHealthMetrics copyWith({
    double? activityRate,
    double? retentionRate,
    double? engagementRate,
    double? growthRate,
    String? healthStatus,
    List<TierRequirementProgress>? tierRequirements,
    String? probationReason,
    DateTime? probationEndDate,
  }) {
    return CommunityHealthMetrics(
      activityRate: activityRate ?? this.activityRate,
      retentionRate: retentionRate ?? this.retentionRate,
      engagementRate: engagementRate ?? this.engagementRate,
      growthRate: growthRate ?? this.growthRate,
      healthStatus: healthStatus ?? this.healthStatus,
      tierRequirements: tierRequirements ?? this.tierRequirements,
      probationReason: probationReason ?? this.probationReason,
      probationEndDate: probationEndDate ?? this.probationEndDate,
    );
  }
}

class TierRequirementProgress {
  final String requirement;
  final dynamic target;
  final dynamic current;
  final bool isCompleted;

  TierRequirementProgress({
    required this.requirement,
    required this.target,
    required this.current,
    required this.isCompleted,
  });

  factory TierRequirementProgress.fromJson(Map<String, dynamic> json) {
    return TierRequirementProgress(
      requirement: json['requirement'] as String,
      target: json['target'],
      current: json['current'],
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requirement': requirement,
      'target': target,
      'current': current,
      'isCompleted': isCompleted,
    };
  }

  TierRequirementProgress copyWith({
    String? requirement,
    dynamic target,
    dynamic current,
    bool? isCompleted,
  }) {
    return TierRequirementProgress(
      requirement: requirement ?? this.requirement,
      target: target ?? this.target,
      current: current ?? this.current,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
