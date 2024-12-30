import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'views/main_layout.dart';

void main() {
  runApp(const MutualAidConnectApp());
}

class MutualAidConnectApp extends StatelessWidget {
  const MutualAidConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Aid Connect',
      theme: AppTheme.darkTheme,
      home: const MainLayout(),
    );
  }
}
