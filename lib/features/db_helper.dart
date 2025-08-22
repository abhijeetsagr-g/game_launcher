import 'package:game_launcher/features/games.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // This makes sure we only ever have ONE DatabaseHelper.
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database; // Add this line.

  // Use a factory constructor to return the single instance.
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'games.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE games(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, command TEXT, path TEXT)",
        );
      },
    );
  }

  Future<void> insertGame(Games game) async {
    final db = await database;
    await db.insert(
      'games',
      game.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Games>> getList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('games');
    return List.generate(maps.length, (i) {
      return Games.fromMap(maps[i]);
    });
  }

  Future<void> updateList(Games game) async {
    final db = await database;
    await db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  Future<void> deleteGame(int id) async {
    final db = await database;
    await db.delete('games', where: 'id = ?', whereArgs: [id]);
  }
}
