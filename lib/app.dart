import 'package:flutter/material.dart';

import 'data/app_info.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

class NihongoApp extends StatelessWidget {
  const NihongoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
