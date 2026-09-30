import 'package:flutter/material.dart';

import '../api/projects_api.dart';
import '../data/project.dart';
import 'widgets/project_tile.dart';

// Shows the list of projects. The data flow is:
//   ProjectsApi (api/)  ->  List<Project> (data/)  ->  this screen
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectsApi _api = ProjectsApi();

  // We store the Future so the data is loaded only once. If we called
  // fetchProjects() inside build(), it would reload on every rebuild.
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _api.fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      // FutureBuilder rebuilds when the Future finishes, so we can show
      // a spinner while loading, an error if it fails, or the data.
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load projects: ${snapshot.error}'),
            );
          }

          final List<Project> projects = snapshot.data ?? [];

          if (projects.isEmpty) {
            return const Center(child: Text('No projects yet.'));
          }

          // ListView.builder only builds the rows that are visible,
          // which keeps long lists fast.
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectTile(project: projects[index]);
            },
          );
        },
      ),
    );
  }
}
