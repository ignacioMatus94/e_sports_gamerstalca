import 'dart:convert';
import 'package:e_sports_gamerstalca/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/models/routine.dart';
import 'package:e_sports_gamerstalca/models/game.dart';
import 'package:e_sports_gamerstalca/services/database_service.dart';
import 'package:e_sports_gamerstalca/screens/progress_screen.dart';
import 'package:e_sports_gamerstalca/screens/profile_screen.dart';
import 'package:e_sports_gamerstalca/screens/history_screen.dart';
import 'package:e_sports_gamerstalca/screens/game_info.dart';
import 'package:e_sports_gamerstalca/timer_service.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  GameDetailsScreenState createState() => GameDetailsScreenState();
}

class GameDetailsScreenState extends State<GameDetailsScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final List<Game> _games = [];
  final Map<int, Set<int>> _selectedRoutinesPerGame = {};
  final Map<int, Map<int, DateTime>> _routineSelectionTimesPerGame = {};
  final Map<int, bool> _isRoutineSelectable = {};
  int _offset = 0;
  final int _limit = 4;

  @override
  void initState() {
    super.initState();
    _loadSelectedRoutines();
    _loadMoreGames();
  }

  Future<void> _loadSelectedRoutines() async {
    for (var routine in widget.game.routines) {
      if (routine.selectedAt != null) {
        _handleRoutineWithSelectedAt(routine);
      } else {
        _isRoutineSelectable[routine.id] = true;
      }
    }
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  Future<void> _loadMoreGames() async {
    try {
      final games = await _databaseService.getGames(limit: _limit, offset: _offset);
      if (games.isNotEmpty) {
        setState(() {
          _games.addAll(games);
          _offset += _limit;
        });
        debugPrint('Games loaded: ${_games.length}');
      } else {
        debugPrint('No more games to load');
      }
    } catch (error) {
      debugPrint('Error loading games: $error');
    }
  }

  void _handleRoutineWithSelectedAt(Routine routine) {
    _selectedRoutinesPerGame.putIfAbsent(widget.game.id, () => {}).add(routine.id);
    final selectedTime = DateTime.parse(routine.selectedAt!);
    _routineSelectionTimesPerGame.putIfAbsent(widget.game.id, () => {})[routine.id] = selectedTime;
    final remainingTime = selectedTime.add(const Duration(seconds: 15)).difference(DateTime.now());

    if (!remainingTime.isNegative) {
      _isRoutineSelectable[routine.id] = false;
    } else {
      _isRoutineSelectable[routine.id] = true;
    }
  }

  bool _canSelectRoutine(Routine routine) {
    return _isRoutineSelectable[routine.id] ?? true;
  }

  Future<void> _toggleRoutineSelection(Routine routine, bool isSelected) async {
    if (isSelected) {
      _selectRoutine(routine);
    } else {
      _deselectRoutine(routine);
    }
    await _databaseService.updateRoutine(routine);
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  void _selectRoutine(Routine routine) {
    _selectedRoutinesPerGame.putIfAbsent(widget.game.id, () => {}).add(routine.id);
    routine.selectedAt = DateTime.now().toIso8601String();
    _isRoutineSelectable[routine.id] = false;
    debugPrint('Routine ${routine.id} selected in GameDetailsScreen');
  }

  void _deselectRoutine(Routine routine) {
    _selectedRoutinesPerGame[widget.game.id]?.remove(routine.id);
    routine.selectedAt = null;
    _isRoutineSelectable[routine.id] = true;
    debugPrint('Routine ${routine.id} deselected in GameDetailsScreen');
  }

  Future<void> _navigateToProgress() async {
    final routines = await _databaseService.getRoutines();
    final selectedRoutines = routines.where((routine) => routine.selectedAt != null).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressScreen(
          routines: selectedRoutines,
          timerService: TimerService(() {}),
        ),
      ),
    ).then((_) async {
      // Recargar datos al regresar
      await _reloadGameAndRoutines();
    });
  }

  Future<void> _reloadGameAndRoutines() async {
    try {
      final updatedGame = await _databaseService.getGameById(widget.game.id);
      final updatedRoutines = await _databaseService.getRoutinesByGameId(widget.game.id);

      setState(() {
        widget.game.routines = updatedRoutines;
        _selectedRoutinesPerGame.clear();
        for (var routine in updatedRoutines) {
          if (routine.selectedAt != null) {
            _handleRoutineWithSelectedAt(routine);
          }
        }
      });
    } catch (error) {
      debugPrint('Error reloading game and routines: $error');
    }
  }

  Widget _buildRoutineCard(Routine routine) {
    final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;
    final isSelected = _selectedRoutinesPerGame[widget.game.id]?.contains(routine.id) ?? false;
    final canSelect = _canSelectRoutine(routine);
    final completedSteps = stepsMap.values.where((value) => value).length;
    final totalSteps = stepsMap.length;
    final progress = totalSteps > 0 ? (completedSteps / totalSteps) * 100 : 0;

    debugPrint('Progress for routine ${routine.id} in GameDetailsScreen build: $progress%');

    return Card(
      child: ExpansionTile(
        title: Text(routine.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dificultad: ${routine.difficulty}'),
          ],
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: canSelect
              ? (bool? value) {
                  _toggleRoutineSelection(routine, value == true);
                }
              : null,
        ),
        children: [
          ListTile(
            leading: Icon(
              progress >= 100
                  ? Icons.check_circle
                  : progress >= 66
                      ? Icons.check_circle_outline
                      : progress >= 33
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
              color: progress >= 100
                  ? Colors.green
                  : progress >= 66
                      ? Colors.orange
                      : progress >= 33
                          ? Colors.yellow
                          : Colors.grey,
            ),
            title: Text('Progreso: ${progress.toStringAsFixed(1)}%'),
          ),
          ...stepsMap.entries.map((entry) {
            return ListTile(
              leading: Icon(entry.value ? Icons.check : Icons.close),
              title: Text(entry.key),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGameCard(Game game) {
    return GestureDetector(
      onTap: () => _navigateToGameDetails(game),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                game.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                game.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            'Detalles del Juego',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(widget.game.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Text(
            widget.game.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.game.description,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Género: ${widget.game.genre}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Año: ${widget.game.year}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Desarrollador: ${widget.game.developer}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Calificación: ${widget.game.rating}', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: ElevatedButton(
            onPressed: _navigateToProgress,
            child: const Text('Ver Progreso'),
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Rutinas',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.game.routines.length,
          itemBuilder: (context, index) {
            final routine = widget.game.routines[index];
            return _buildRoutineCard(routine);
          },
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Otros Juegos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _games.length,
          itemBuilder: (context, index) {
            final game = _games[index];
            return _buildGameCard(game);
          },
        ),
      ],
    );
  }

  void _navigateToGameDetails(Game game) {
    debugPrint('Navigating to Game Details for game: ${game.name}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailsScreen(game: game),
      ),
    ).then((value) async {
      // Recargar datos al regresar
      await _reloadGameAndRoutines();
    });
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Displaying details for game: ${widget.game.name}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.game.name,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Menú de Navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Inicio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToHomeScreen(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.gamepad),
              title: const Text(
                'Juegos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToGameDetails(widget.game);
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text(
                'Progreso',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToProgress();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Perfil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                'Historial',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(
                      progressMap: {}, // Pasa tu mapa de progreso aquí
                      routines: [], // Pasa tus rutinas aquí
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'Información de Juegos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameInfoScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildGameDetails(),
      ),
    );
  }
}
