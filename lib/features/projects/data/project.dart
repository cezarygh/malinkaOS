class Project {
  final int? id;
  final String name;
  final String description;

  const Project({this.id, required this.name, required this.description});

  Map<String, Object?> toMap() {
    return {'name': name, 'description': description};
  }

  factory Project.fromMap(Map<String, Object?> map) {
    return Project(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}