import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'project_cubit.dart';
import 'project_state.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ProjectCubit(),
    child: const _ProjectView(),
  );
}

class _ProjectView extends StatelessWidget {
  const _ProjectView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: BlocConsumer<ProjectCubit, ProjectState>(
        // Only react when status changes to saved.
        listenWhen: (previous, current) =>
        previous.status != current.status &&
            current.status == ProjectStatus.saved,
        listener: (context, _) => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Project saved'))),
        builder: (context, state) {
          final cubit = context.read<ProjectCubit>();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: cubit.nameChanged,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: cubit.descriptionChanged,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: state.status == ProjectStatus.saving
                      ? null
                      : cubit.submit,
                  child: const Text('Create project'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}