import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/models/routine.dart';
import 'package:e_sports_gamerstalca/models/game.dart';
import 'package:e_sports_gamerstalca/services/database_service.dart';
import 'package:e_sports_gamerstalca/screens/game_details_screen.dart';
import 'package:e_sports_gamerstalca/screens/progress_screen.dart';
import 'package:e_sports_gamerstalca/screens/profile_screen.dart';
import 'package:e_sports_gamerstalca/screens/history_screen.dart';
import 'package:e_sports_gamerstalca/screens/game_info.dart';
import 'package:e_sports_gamerstalca/timer_service.dart';
import '../app_drawer.dart'; // Importa el AppDrawer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final List<Game> _games = [];
  List<Routine> _routines = [];
  final Map<int, double> _progressMap = {};
  int _offset = 0;
  final int _limit = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreGames();
    _loadRoutines();
  }

  Future<void> _loadMoreGames() async {
    setState(() {
      _isLoading = true;
    });

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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadRoutines() async {
    try {
      final routines = await _databaseService.getRoutines() ?? [];
      setState(() {
        _routines = routines;
        _progressMap.addAll({ for (var routine in routines) routine.id : routine.progress });
      });
      debugPrint('Routines loaded: ${_routines.length}');
    } catch (error) {
      debugPrint('Error loading routines: $error');
      setState(() {
        _routines = []; // Ensure _routines is not null
      });
    }
  }

  void _navigateToGameDetails(Game game) {
    debugPrint('Navigating to Game Details for game: ${game.name}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailsScreen(game: game),
      ),
    ).then((value) => debugPrint('Returned from Game Details'));
  }

  Future<void> _navigateToProgress() async {
    debugPrint('Navigating to Progress Screen');
    final selectedRoutines = _routines.where((routine) => routine.selectedAt != null).toList();
    if (selectedRoutines.isEmpty) {
      await _loadRoutines();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressScreen(
          routines: selectedRoutines,
          timerService: TimerService(() {}),
        ),
      ),
    ).then((value) async {
      await _loadRoutines();
      setState(() {
        _progressMap.clear();
        _progressMap.addAll({ for (var routine in _routines) routine.id : routine.progress });
      });
      debugPrint('Returned from Progress Screen');
    });
  }

  void _navigateToProfile() {
    debugPrint('Navigating to Profile Screen');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    ).then((value) => debugPrint('Returned from Profile Screen'));
  }

  void _navigateToHistory() {
    debugPrint('Navigating to History Screen');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          progressMap: _progressMap,
          routines: _routines.where((routine) => routine.selectedAt != null).toList(),
        ),
      ),
    ).then((value) => debugPrint('Returned from History Screen'));
  }

  void _navigateToGameInfo() {
    debugPrint('Navigating to Game Info');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameInfoScreen(),
      ),
    ).then((value) => debugPrint('Returned from Game Info Screen'));
  }

  Widget _buildNavigationCard(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 50, color: Theme.of(context).primaryColor),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E_SPORTS_GAMERSTALCA'),
      ),
      drawer: AppDrawer(), // Usar el Drawer aquí
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                _buildNavigationCard('Juegos', Icons.gamepad, () {
                  if (_games.isNotEmpty) {
                    _navigateToGameDetails(_games[0]);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No hay juegos disponibles')),
                    );
                  }
                }),
                _buildNavigationCard('Progreso', Icons.show_chart, _navigateToProgress),
                _buildNavigationCard('Perfil', Icons.person, _navigateToProfile),
                _buildNavigationCard('Historial', Icons.history, _navigateToHistory),
                _buildNavigationCard('Información de Juegos', Icons.info, _navigateToGameInfo),
              ],
            ),
    );
  }
}
