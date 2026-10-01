import 'package:sqflite/sqflite.dart';

class Malinkadb {
  static Database? _database;

  static Future<Database> get database async {

    _database ??= await openDatabase(
      'malinka.db',
      version: 1,

      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
    return _database!;
  }
}