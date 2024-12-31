import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/shared/presentation/layouts/main_navigation_layout.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MutualAidConnectApp());
}

class MutualAidConnectApp extends StatelessWidget {
  const MutualAidConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Aid Connect',
      theme: AppTheme.darkTheme,
      home: const MainNavigationLayout(),
    );
  }
}
