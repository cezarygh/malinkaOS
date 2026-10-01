import 'package:flutter/material.dart';

import '../../projects/data/project.dart';
import '../../projects/data/project_repository.dart';

// The Dashboard page: shows all saved projects.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Project> _projects = [];

  // initState runs once, when the page is first created.
  @override
  void initState() {
    super.initState();
    _load();
    ProjectRepository.changes.addListener(_load);
  }

  @override
  void dispose() {
    ProjectRepository.changes.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    final projects = await ProjectRepository.getAll();
    if (!mounted) return;
    setState(() {
      _projects = projects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: _projects.isEmpty
          ? const Center(child: Text('No projects yet'))
          : ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ListTile(
            title: Text(project.name),
            subtitle: Text(project.description),
          );
        },
      ),
    );
  }
}