enum ProjectStatus { editing, saving, saved }

class ProjectState {
  const ProjectState({
    this.name = '',
    this.description = '',
    this.status = ProjectStatus.editing,
  });

  final String name;
  final String description;
  final ProjectStatus status;

  ProjectState copyWith({
    String? name,
    String? description,
    ProjectStatus? status,
  }) {
    return ProjectState(
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}