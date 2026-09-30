// A model is a plain Dart class that describes one piece of data.
// When a database is added, each row in the "projects" table will be
// turned into one Project object.
class Project {
  final String id;
  final String name;
  final String description;
  final ProjectStatus status;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });
}

// An enum is a fixed list of allowed values. Using it instead of a String
// means a typo like 'compleated' becomes a compile error.
enum ProjectStatus { planned, inProgress, completed }
