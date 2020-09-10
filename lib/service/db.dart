import 'package:flutter_localdb/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database _database;
  final String table = 'notes';

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await initDB();
    print(_database);

    return _database;
  }

  // Delete the database
  deleteDB() async {
    var dir = await getDatabasesPath();
    String path = join(dir, 'noteup.db');

    await deleteDatabase(path);
  }

  initDB() async {
    var dir = await getDatabasesPath();
    String path = join(dir, 'noteup.db');
    var sql =
        "CREATE TABLE $table ( id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, phone TEXT, no INTEGER ,created_at TEXT created_at TEXT DEFAULT CURRENT_TIMESTAMP)";

    var database =
        await openDatabase(path, version: 2, onCreate: (_db, v) async {
      // await _db.execute(
      //     'CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,content TEXT)');
      await _db.execute(sql);
    });
    print("Create ::::");
    return database;
  }

  Future<void> add(Note note) async {
    var database = await db;
    var result = await database.insert(table, note.toMap());
    print("Result $result");
  }

  Future<List<Note>> searchNotes(s) async {
    var database = await db;
    List<Map<String, dynamic>> maps =
        await database.rawQuery("SELECT * FROM $table WHERE name='$s'");
    List<Note> notes = new List();
    for (var item in maps) {
      notes.add(Note.fromMap(item));
    }
    print("Notes count:::: ${notes.length}");
    return notes;
  }

  Future<List<Note>> getNotes() async {
    var database = await db;
    List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT * FROM $table ORDER BY id DESC');
    List<Note> notes = new List();
    for (var item in maps) {
      notes.add(Note.fromMap(item));
    }
    print("Notes count:::: ${notes.length}");
    return notes;
  }
}

