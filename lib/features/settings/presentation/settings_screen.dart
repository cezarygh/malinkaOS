import 'package:flutter/material.dart';

import 'widgets/settings_section.dart';

// The settings page. For now it only shows information; settings that
// can be changed and saved will come later.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SettingsSection(
            title: 'General',
            children: [
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('Theme'),
                subtitle: Text('Follows your device setting'),
              ),
            ],
          ),
          SettingsSection(
            title: 'About',
            children: [
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Version'),
                subtitle: Text('0.1.0'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
