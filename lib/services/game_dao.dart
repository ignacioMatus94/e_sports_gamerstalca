import 'package:sqflite/sqflite.dart';
import '../models/juego.dart';
import '../services/database_service.dart';

class GameDao {
  Future<void> insertGame(Juego game) async {
    final db = await DatabaseService().database;
    await db.insert(
      'juego',
      game.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Juego>> getGames() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('juego');
    return List.generate(maps.length, (i) {
      return Juego.fromMap(maps[i]);
    });
  }

  Future<Juego?> getGameById(int id) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'juego',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Juego.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateGame(Juego game) async {
    final db = await DatabaseService().database;
    await db.update(
      'juego',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  Future<void> deleteGame(int id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'juego',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
