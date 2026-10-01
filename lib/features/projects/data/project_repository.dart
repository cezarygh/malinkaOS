import 'package:flutter/foundation.dart';
import '../../../shared/db/malinkadb.dart';
import 'project.dart';

class ProjectRepository {
  static final ValueNotifier<int> changes = ValueNotifier(0);

  static Future<void> insert(Project project) async {
    final db = await Malinkadb.database;
    await db.insert('projects', project.toMap());
    changes.value++;
  }

  static Future<List<Project>> getAll() async {
    final db = await Malinkadb.database;
    final rows = await db.query('projects', orderBy: 'id DESC');
    return rows.map(Project.fromMap).toList();
  }
}