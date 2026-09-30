import 'package:flutter/material.dart';

// The Projects page. It is empty for now; content will be added later.
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold gives the page its basic structure: an app bar at the top
    // and a body below it.
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: const Center(child: Text('Projects')),
    );
  }
}
