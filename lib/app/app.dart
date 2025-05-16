import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_nextgen/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:volt_nextgen/presentation/theme/app_theme.dart';

class VoltRunningApp extends ConsumerWidget {
  const VoltRunningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Volt Running',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
