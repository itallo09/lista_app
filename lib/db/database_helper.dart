import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'tarefa.dart'; // Importe a classe Tarefa

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var pathDatabase = path.join(documentsDirectory.path, 'todo.db');

    return await openDatabase(pathDatabase, version: 2, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        titulo TEXT,
        concluida INTEGER
      )
    ''');
  }

  Future<int> adicionarTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.insert('tasks', tarefa.toMap());
  }

  Future<List<Tarefa>> recuperarTarefas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Tarefa(
        id: maps[i]['id'],
        titulo: maps[i]['titulo'],
        concluida: maps[i]['concluida'],
      );
    });
  }

  Future<int> removerTarefa(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
