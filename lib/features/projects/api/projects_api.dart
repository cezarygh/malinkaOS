import '../data/project.dart';

// The api class is the only place that knows where project data comes
// from. Screens call fetchProjects() and don't care how it works.
//
// Right now it returns hardcoded projects. Later, only the body of
// fetchProjects() needs to change to read from a real database.
class ProjectsApi {
  // Future means "a value that arrives later". Database and network
  // calls always return Futures because they take time.
  Future<List<Project>> fetchProjects() async {
    // Pretend the data takes a moment to load, like a real database.
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      Project(
        id: '1',
        name: 'Website redesign',
        description: 'New look for the company website.',
        status: ProjectStatus.inProgress,
      ),
      Project(
        id: '2',
        name: 'Mobile app',
        description: 'First version of the Malinkaos app.',
        status: ProjectStatus.planned,
      ),
      Project(
        id: '3',
        name: 'Office move',
        description: 'Move to the new office.',
        status: ProjectStatus.completed,
      ),
    ];
  }
}
