import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/juego.dart';
import '../models/rutina.dart';
import '../models/avance.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE rutinas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            descripcion TEXT,
            objetivo TEXT,
            pasos TEXT,
            resultadosEsperados TEXT,
            dificultad TEXT,
            puntuacion REAL,
            juegoId INTEGER,
            perfil_id INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE avances (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            perfil_id INTEGER,
            rutina_id INTEGER,
            juego_id INTEGER,
            nombre TEXT,
            descripcion TEXT,
            objetivo TEXT,
            pasos TEXT,
            resultadosEsperados TEXT,
            dificultad TEXT,
            puntuacion REAL,
            fecha TEXT,
            progreso INTEGER
          )
        ''');
      },
    );
  }

  Future<void> initializeDatabase() async {
    await _initializeDatabase();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
    _database = null;
  }

  Future<void> insertarRutinasIniciales(List<Juego> juegos) async {
    final db = await database;
    for (var juego in juegos) {
      for (var rutina in juego.rutinas) {
        await db.insert('rutinas', rutina.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<Map<String, dynamic>?> getRutinaSeleccionada(int perfilId, int juegoId) async {
    final db = await database;

    try {
      final List<Map<String, dynamic>> result = await db.query(
        'rutinas',
        where: 'perfil_id = ? AND juegoId = ?',
        whereArgs: [perfilId, juegoId],
      );

      if (result.isNotEmpty) {
        return result.first; // Devuelve el primer resultado como un Map
      } else {
        return null; // No se encontraron rutinas
      }
    } catch (e) {
      print('Error querying rutina: $e');
      throw Exception('Error querying rutina');
    }
  }

  Future<void> deleteRutinaForPerfil(int perfilId, int juegoId) async {
    final db = await database;
    await db.delete('rutinas', where: 'perfil_id = ? AND juegoId = ?', whereArgs: [perfilId, juegoId]);
  }

  Future<void> selectRutinaForPerfil(int perfilId, int rutinaId, int juegoId) async {
    final db = await database;
    await db.update('rutinas', {'perfil_id': perfilId}, where: 'id = ?', whereArgs: [rutinaId]);
  }

  Future<void> insertAvance(Avance avance) async {
    final db = await database;
    await db.insert('avances', avance.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Avance>> getAvances(int perfilId, int rutinaId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'avances',
      where: 'perfil_id = ? AND rutina_id = ?',
      whereArgs: [perfilId, rutinaId],
    );

    return result.isNotEmpty ? result.map((json) => Avance.fromMap(json)).toList() : [];
  }

  Future<List<Map<String, dynamic>>> getHistoriales(int rutinaId) async {
    final db = await database;
    return await db.query('avances', where: 'rutina_id = ?', whereArgs: [rutinaId]);
  }

  Future<void> insertRutina(Rutina rutina) async {
    final db = await database;
    await db.insert('rutinas', rutina.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Rutina?> getRutina(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('rutinas', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Rutina.fromMap(result.first);
    }
    return null;
  }
}
