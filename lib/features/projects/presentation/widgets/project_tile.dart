import 'package:flutter/material.dart';

import '../../data/project.dart';

// One row in the projects list.
class ProjectTile extends StatelessWidget {
  final Project project;

  const ProjectTile({super.key, required this.project});

  // Turn the enum value into text the user can read.
  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.planned:
        return 'Planned';
      case ProjectStatus.inProgress:
        return 'In progress';
      case ProjectStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.folder),
        title: Text(project.name),
        subtitle: Text(project.description),
        trailing: Chip(label: Text(_statusLabel(project.status))),
      ),
    );
  }
}
