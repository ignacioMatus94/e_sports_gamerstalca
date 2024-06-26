import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../models/juego.dart';
import '../models/historial.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static final _lock = Lock();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
      }
      return _database!;
    });
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: _onUpgrade,
      version: 1,
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS perfil(id INTEGER PRIMARY KEY, nombreUsuario TEXT, email TEXT, avatarUrl TEXT, nivel INTEGER, puntos INTEGER)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS rutina(id INTEGER PRIMARY KEY, nombre TEXT, descripcion TEXT, objetivo TEXT, pasos TEXT, resultadosEsperados TEXT, dificultad TEXT)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS historial(id INTEGER PRIMARY KEY, rutinaId INTEGER, descripcion TEXT, fecha TEXT)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS rutina_seleccionada(id INTEGER PRIMARY KEY AUTOINCREMENT, perfilId INTEGER, rutinaId INTEGER, juegoId INTEGER)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS juego(id INTEGER PRIMARY KEY, nombre TEXT, imagenUrl TEXT, genero TEXT, ano INTEGER, desarrollador TEXT, descripcion TEXT, link TEXT, puntuacion REAL)",
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Cambios en la estructura de la base de datos para la versión 2
    }
    // Agrega más bloques if para futuras versiones
  }

  Future<void> clearTable(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }

  Future<int> getRowCount(String tableName) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName'))!;
  }

  Future<List<Perfil>> searchPerfilesByName(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'perfil',
      where: 'nombreUsuario LIKE ?',
      whereArgs: ['%$name%'],
    );
    return List.generate(maps.length, (i) {
      return Perfil.fromMap(maps[i]);
    });
  }

  Future<List<Juego>> filterJuegosByGenero(String genero) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'juego',
      where: 'genero = ?',
      whereArgs: [genero],
    );
    return List.generate(maps.length, (i) {
      return Juego.fromMap(maps[i]);
    });
  }

  Future<void> insertPerfil(Perfil perfil) async {
    try {
      final db = await database;
      await db.insert(
        'perfil',
        perfil.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error insertando perfil: $e');
    }
  }

  Future<List<Perfil>> getPerfiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('perfil');
    return List.generate(maps.length, (i) {
      return Perfil.fromMap(maps[i]);
    });
  }

  Future<void> updatePerfil(Perfil perfil) async {
    final db = await database;
    await db.update(
      'perfil',
      perfil.toMap(),
      where: 'id = ?',
      whereArgs: [perfil.id],
    );
  }

  Future<void> deletePerfil(int id) async {
    final db = await database;
    await db.delete(
      'perfil',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertRutina(Rutina rutina) async {
    final db = await database;
    try {
      final int id = await db.insert(
        'rutina',
        rutina.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted rutina with id $id');
    } catch (e) {
      print('Error insertando rutina: $e');
    }
  }

  Future<void> updateRutina(Rutina rutina) async {
    final db = await database;
    await db.update(
      'rutina',
      rutina.toMap(),
      where: 'id = ?',
      whereArgs: [rutina.id],
    );
  }

  Future<void> deleteRutina(int id) async {
    final db = await database;
    await db.delete(
      'rutina',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertHistorial(Historial historial) async {
    final db = await database;
    try {
      final int id = await db.insert(
        'historial',
        historial.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted historial with id $id');
    } catch (e) {
      print('Error insertando historial: $e');
    }
  }

  Future<void> updateHistorial(Historial historial) async {
    final db = await database;
    await db.update(
      'historial',
      historial.toMap(),
      where: 'id = ?',
      whereArgs: [historial.id],
    );
  }

  Future<void> deleteHistorial(int id) async {
    final db = await database;
    await db.delete(
      'historial',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Historial>> getHistoriales(int rutinaId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'historial',
      where: 'rutinaId = ?',
      whereArgs: [rutinaId],
    );
    return List.generate(maps.length, (i) {
      return Historial.fromMap(maps[i]);
    });
  }

  Future<void> insertJuego(Juego juego) async {
    final db = await database;
    try {
      final int id = await db.insert(
        'juego',
        juego.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted juego with id $id');
    } catch (e) {
      print('Error insertando juego: $e');
    }
  }

  Future<List<Juego>> getJuegos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('juego');
    return List.generate(maps.length, (i) {
      return Juego.fromMap(maps[i]);
    });
  }

  Future<void> updateJuego(Juego juego) async {
    final db = await database;
    await db.update(
      'juego',
      juego.toMap(),
      where: 'id = ?',
      whereArgs: [juego.id],
    );
  }

  Future<void> deleteJuego(int id) async {
    final db = await database;
    await db.delete(
      'juego',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Rutina?> getRutinaSeleccionada(int perfilId, int juegoId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'rutina_seleccionada',
      where: 'perfilId = ? AND juegoId = ?',
      whereArgs: [perfilId, juegoId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final rutinaId = maps.first['rutinaId'] as int;
      print('Found selected rutinaId $rutinaId for perfilId $perfilId and juegoId $juegoId');
      
      final List<Map<String, dynamic>> rutinaMaps = await db.query(
        'rutina',
        where: 'id = ?',
        whereArgs: [rutinaId],
        limit: 1,
      );

      if (rutinaMaps.isNotEmpty) {
        print('Found rutina: ${rutinaMaps.first}');
        return Rutina.fromMap(rutinaMaps.first);
      } else {
        print('No rutina found for rutinaId $rutinaId');
      }
    } else {
      print('No rutina seleccionada found for perfilId $perfilId and juegoId $juegoId');
    }

    return null;
  }

  Future<void> saveRutinaSeleccionada(int perfilId, int rutinaId, int juegoId) async {
    final db = await database;
    final int deletedRows = await db.delete(
      'rutina_seleccionada',
      where: 'perfilId = ? AND juegoId = ?',
      whereArgs: [perfilId, juegoId],
    );
    print('Deleted $deletedRows rows from rutina_seleccionada');

    final int id = await db.insert(
      'rutina_seleccionada',
      {'perfilId': perfilId, 'rutinaId': rutinaId, 'juegoId': juegoId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted rutina_seleccionada with id $id');

    await insertHistorial(
      Historial(
        id: 0,
        rutinaId: rutinaId,
        descripcion: 'Rutina seleccionada',
        fecha: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = join(await getDatabasesPath(), 'app_database.db');
    await deleteDatabase(dbPath);
    _database = null;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
