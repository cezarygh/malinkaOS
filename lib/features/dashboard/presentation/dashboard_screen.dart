import 'package:flutter/material.dart';

// The Dashboard page. It is empty for now; content will be added later.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold gives the page its basic structure: an app bar at the top
    // and a body below it.
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(child: Text('Dashboard')),
    );
  }
}
