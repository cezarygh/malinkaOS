import 'package:flutter/material.dart';

// The Settings page. It is empty for now; content will be added later.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold gives the page its basic structure: an app bar at the top
    // and a body below it.
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings')),
    );
  }
}
