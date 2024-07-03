import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/game.dart';
import '../models/routine.dart';
import '../models/profile.dart';
import '../models/profile_routine.dart';
import '../obtener_juegos.dart';
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<void> initializeDatabase() async {
    await database; // Inicializa la base de datos
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Profiles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE Games (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        genre TEXT,
        year INTEGER,
        developer TEXT,
        link TEXT,
        rating REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE Routines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        objective TEXT,
        steps TEXT,
        expectedResults TEXT,
        difficulty TEXT,
        rating REAL,
        gameId INTEGER,
        selectedAt TEXT,
        FOREIGN KEY (gameId) REFERENCES Games(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE ProfileRoutines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        profileId INTEGER,
        routineId INTEGER,
        selectedDate TEXT,
        progress INTEGER,
        FOREIGN KEY (profileId) REFERENCES Profiles(id),
        FOREIGN KEY (routineId) REFERENCES Routines(id)
      )
    ''');

    // Insertar juegos y rutinas de prueba
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    List<Game> juegos = obtenerJuegos();
    for (var game in juegos) {
      debugPrint('Inserting game: ${game.name}');
      int gameId = await db.insert('Games', game.toMap());
      for (var routine in game.routines) {
        debugPrint('Inserting routine: ${routine.name} for game ID: $gameId');
        routine = routine.copyWith(gameId: gameId);
        await db.insert('Routines', routine.toMap());
      }
    }
  }

  Future<List<Game>> getGames({int limit = 10, int offset = 0}) async {
    final db = await database;
    final result = await db.query('Games', limit: limit, offset: offset);
    debugPrint('Loaded games: ${result.length}');
    List<Game> games = result.map((map) => Game.fromMap(map)).toList();

    for (var game in games) {
      final routinesResult = await db.query('Routines', where: 'gameId = ?', whereArgs: [game.id]);
      List<Routine> routines = routinesResult.map((map) => Routine.fromMap(map)).toList();
      game.routines = routines;
    }

    return games;
  }

  Future<void> updateRoutine(Routine routine) async {
    final db = await database;
    await db.update('Routines', routine.toMap(), where: 'id = ?', whereArgs: [routine.id]);
  }

  Future<Routine> getRoutineById(int id) async {
    final db = await database;
    final result = await db.query('Routines', where: 'id = ?', whereArgs: [id], limit: 1);
    if (result.isNotEmpty) {
      return Routine.fromMap(result.first);
    } else {
      throw Exception('Routine not found');
    }
  }

  Future<Game> getGameById(int id) async {
    final db = await database;
    final result = await db.query('Games', where: 'id = ?', whereArgs: [id], limit: 1);
    if (result.isNotEmpty) {
      return Game.fromMap(result.first);
    } else {
      throw Exception('Game not found');
    }
  }

  Future<List<Routine>> getRoutinesByGameId(int gameId) async {
    final db = await database;
    final result = await db.query('Routines', where: 'gameId = ?', whereArgs: [gameId]);
    return result.map((map) => Routine.fromMap(map)).toList();
  }

  Future<List<Routine>> getRoutines() async {
    final db = await database;
    final result = await db.query('Routines');
    return result.map((map) => Routine.fromMap(map)).toList();
  }

  Future<List<Profile>> getProfiles() async {
    final db = await database;
    final result = await db.query('Profiles');
    return result.map((map) => Profile.fromMap(map)).toList();
  }

  Future<List<ProfileRoutine>> getProfileRoutines() async {
    final db = await database;
    final result = await db.query('ProfileRoutines');
    return result.map((map) => ProfileRoutine.fromMap(map)).toList();
  }

  Future<int> insertProfile(Profile profile) async {
    final db = await database;
    return await db.insert('Profiles', profile.toMap());
  }

  Future<int> updateProfile(Profile profile) async {
    final db = await database;
    return await db.update('Profiles', profile.toMap(), where: 'id = ?', whereArgs: [profile.id]);
  }

  Future<int> deleteProfile(int id) async {
    final db = await database;
    return await db.delete('Profiles', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertProfileRoutine(ProfileRoutine profileRoutine) async {
    final db = await database;
    return await db.insert('ProfileRoutines', profileRoutine.toMap());
  }

  Future<int> updateProfileRoutine(ProfileRoutine profileRoutine) async {
    final db = await database;
    return await db.update('ProfileRoutines', profileRoutine.toMap(), where: 'id = ?', whereArgs: [profileRoutine.id]);
  }

  Future<int> deleteProfileRoutine(int id) async {
    final db = await database;
    return await db.delete('ProfileRoutines', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Routine>> getSelectedRoutinesForProfile(int profileId) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT Routines.*
      FROM Routines
      INNER JOIN ProfileRoutines ON Routines.id = ProfileRoutines.routineId
      WHERE ProfileRoutines.profileId = ?
    ''', [profileId]);

    return result.map((map) => Routine.fromMap(map)).toList();
  }

  Future<void> saveRoutines(List<Routine> routines) async {
    final db = await database;
    for (var routine in routines) {
      await db.insert('Routines', routine.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Routine>> loadRoutines() async {
    final db = await database;
    final result = await db.query('Routines');
    return result.map((map) => Routine.fromMap(map)).toList();
  }
}
