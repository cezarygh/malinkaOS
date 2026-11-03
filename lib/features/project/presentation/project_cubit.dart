import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/project.dart';
import '../data/project_repository.dart';
import 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(const ProjectState());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: ProjectStatus.editing));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, status: ProjectStatus.editing));
  }

  Future<void> submit() async {
    final name = state.name.trim();
    if (name.isEmpty || state.status == ProjectStatus.saving) return;

    emit(state.copyWith(status: ProjectStatus.saving));
    await ProjectRepository.insert(
      Project(name: name, description: state.description.trim()),
    );
    // The screen may have closed while we waited for the database.
    if (isClosed) return;
    emit(state.copyWith(status: ProjectStatus.saved));
  }
}