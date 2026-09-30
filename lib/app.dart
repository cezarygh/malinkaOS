import 'package:flutter/material.dart';

import 'shared/navigation/app_shell.dart';
import 'shared/theme/app_theme.dart';

// The root widget. MaterialApp sets up app-wide things like the theme,
// the app title and the first screen (home).
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Malinkaos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Follow the light/dark setting of the phone or computer.
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}
