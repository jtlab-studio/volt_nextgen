import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme provider for controlling light/dark mode
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  // Set the theme mode
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  // Use the system theme
  void useSystemTheme() {
    state = ThemeMode.system;
  }

  // Set dark mode
  void setDarkMode() {
    state = ThemeMode.dark;
  }

  // Set light mode
  void setLightMode() {
    state = ThemeMode.light;
  }
}

// Provider for checking if current theme is dark
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  final platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  
  // If system mode, use the platform brightness, otherwise use the selected mode
  return themeMode == ThemeMode.system
      ? platformBrightness == Brightness.dark
      : themeMode == ThemeMode.dark;
});

// Provider for getting the current theme brightness
final brightnessModeProvider = Provider<Brightness>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? Brightness.dark : Brightness.light;
});
