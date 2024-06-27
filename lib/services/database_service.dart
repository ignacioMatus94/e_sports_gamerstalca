import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/juego.dart';
import '../models/rutina.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE perfiles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            avatarUrl TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE rutinas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            descripcion TEXT,
            objetivo TEXT,
            pasos TEXT,
            resultadosEsperados TEXT,
            dificultad TEXT,
            juego_id INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE perfil_rutinas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            perfil_id INTEGER,
            rutina_id INTEGER,
            juego_id INTEGER,
            FOREIGN KEY(perfil_id) REFERENCES perfiles(id),
            FOREIGN KEY(rutina_id) REFERENCES rutinas(id)
          )
        ''');
      },
    );
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
    _database = null; // Reset the database instance
  }

  Future<void> insertPerfil(Map<String, dynamic> perfil) async {
    final db = await database;
    await db.insert('perfiles', perfil, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertRutina(Map<String, dynamic> rutina) async {
    final db = await database;
    await db.insert('rutinas', rutina, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> selectRutinaForPerfil(int perfilId, int rutinaId, int juegoId) async {
    final db = await database;
    await db.insert('perfil_rutinas', {'perfil_id': perfilId, 'rutina_id': rutinaId, 'juego_id': juegoId}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteRutinaForPerfil(int perfilId, int juegoId) async {
    final db = await database;
    await db.delete('perfil_rutinas', where: 'perfil_id = ? AND juego_id = ?', whereArgs: [perfilId, juegoId]);
  }

  Future<Map<String, dynamic>?> getRutinaSeleccionada(int perfilId, int juegoId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT r.* FROM rutinas r '
      'INNER JOIN perfil_rutinas pr ON r.id = pr.rutina_id '
      'WHERE pr.perfil_id = ? AND pr.juego_id = ?',
      [perfilId, juegoId]
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<void> deleteRutinasForPerfil(int perfilId) async {
    final db = await database;
    await db.delete('perfil_rutinas', where: 'perfil_id = ?', whereArgs: [perfilId]);
  }

  Future<List<Map<String, dynamic>>> getRutinasSeleccionadas(int perfilId) async {
    final db = await database;
    return await db.rawQuery(
      'SELECT pr.rutina_id, r.* FROM perfil_rutinas pr '
      'INNER JOIN rutinas r ON pr.rutina_id = r.id '
      'WHERE pr.perfil_id = ?',
      [perfilId]
    );
  }

  Future<List<Map<String, dynamic>>> getHistoriales(int rutinaId) async {
    final db = await database;
    // Aquí debes implementar la lógica para obtener los historiales
    return [];
  }

  Future<void> insertarRutinasIniciales(List<Juego> juegos) async {
    final db = await database;
    for (var juego in juegos) {
      for (var rutina in juego.rutinas) {
        await insertRutina({
          ...rutina.toMap(),
          'juego_id': juego.id,
        });
      }
    }
  }
}
