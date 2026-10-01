import 'package:flutter/material.dart';

import '../data/project.dart';
import '../data/project_repository.dart';

// The Projects page: a small form for creating a new project.
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Controllers must be cleaned up when the page is removed.
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    if (name.isEmpty) return;

    await ProjectRepository.insert(
      Project(name: name, description: description),
    );

    _nameController.clear();
    _descriptionController.clear();

    // After an await the page might be gone, so check before using context.
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Project saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _save, child: const Text('Create project')),
          ],
        ),
      ),
    );
  }
}
