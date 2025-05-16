import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_nextgen/core/constants/social_tier.dart';
import 'package:volt_nextgen/data/models/user_model.dart';

// Define a provider for the current user
final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(
          // Initialize with a placeholder user
          UserModel(
            id: 'user-1',
            name: 'Alex Runner',
            email: 'alex@example.com',
            profileImageUrl: null,
            tier: SocialTier.clan,
            stats: UserStats(
              totalActivities: 42,
              totalDistance: 235.7,
              totalDuration: 75600, // 21 hours
              currentStreak: 7,
              bestStreak: 21,
            ),
            communityIds: ['community-1'],
            settings: Settings(
              darkMode: true,
              metricUnits: true,
              thresholds: ThresholdSettings(
                lthr: 172,
                criticalPower: 250,
                thresholdPace: '5:30',
              ),
              notifications: NotificationSettings(
                activityReminders: true,
                socialNotifications: true,
                goalAlerts: true,
              ),
            ),
          ),
        );

  // Update user information
  void updateUser(UserModel updatedUser) {
    state = updatedUser;
  }

  // Update specific user stats
  void updateUserStats(UserStats stats) {
    state = state.copyWith(stats: stats);
  }

  // Update specific user settings
  void updateUserSettings(Settings settings) {
    state = state.copyWith(settings: settings);
  }

  // Update user tier
  void updateUserTier(SocialTier tier) {
    state = state.copyWith(tier: tier);
  }

  // Add a community to the user's communities
  void addCommunity(String communityId) {
    final updatedCommunityIds = List<String>.from(state.communityIds)
      ..add(communityId);
    state = state.copyWith(communityIds: updatedCommunityIds);
  }

  // Remove a community from the user's communities
  void removeCommunity(String communityId) {
    final updatedCommunityIds = List<String>.from(state.communityIds)
      ..remove(communityId);
    state = state.copyWith(communityIds: updatedCommunityIds);
  }

  // Toggle the app theme between dark and light mode
  void toggleDarkMode() {
    final updatedSettings = state.settings.copyWith(
      darkMode: !state.settings.darkMode,
    );
    state = state.copyWith(settings: updatedSettings);
  }

  // Toggle between metric and imperial units
  void toggleUnits() {
    final updatedSettings = state.settings.copyWith(
      metricUnits: !state.settings.metricUnits,
    );
    state = state.copyWith(settings: updatedSettings);
  }

  // Update training thresholds
  void updateThresholds({int? lthr, int? criticalPower, String? thresholdPace}) {
    final updatedThresholds = state.settings.thresholds.copyWith(
      lthr: lthr,
      criticalPower: criticalPower,
      thresholdPace: thresholdPace,
    );
    
    final updatedSettings = state.settings.copyWith(
      thresholds: updatedThresholds,
    );
    
    state = state.copyWith(settings: updatedSettings);
  }

  // Update notification settings
  void updateNotificationSettings({
    bool? activityReminders,
    bool? socialNotifications,
    bool? goalAlerts,
  }) {
    final updatedNotifications = state.settings.notifications.copyWith(
      activityReminders: activityReminders,
      socialNotifications: socialNotifications,
      goalAlerts: goalAlerts,
    );
    
    final updatedSettings = state.settings.copyWith(
      notifications: updatedNotifications,
    );
    
    state = state.copyWith(settings: updatedSettings);
  }
}
