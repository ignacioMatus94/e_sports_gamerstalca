import 'package:e_sports_gamerstalca/models/game.dart';
import 'package:e_sports_gamerstalca/models/routine.dart';
import 'package:e_sports_gamerstalca/screens/game_details_screen.dart';
import 'package:e_sports_gamerstalca/screens/game_info.dart';
import 'package:e_sports_gamerstalca/screens/home_screen.dart';
import 'package:e_sports_gamerstalca/screens/profile_screen.dart';
import 'package:e_sports_gamerstalca/screens/progress_screen.dart';
import 'package:e_sports_gamerstalca/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/history.dart';
import '../services/database_service.dart';

class HistoryScreen extends StatelessWidget {
  final Map<int, double> progressMap;
  final List<Routine> routines;

  const HistoryScreen({
    super.key,
    required this.progressMap,
    required this.routines,
  });

  Future<List<History>> _fetchHistory() async {
    final histories = await DatabaseService().getAllHistory();
    debugPrint('Fetched ${histories.length} history records');
    return histories;
  }

  Future<Map<int, Game>> _fetchGames() async {
    final gamesList = await DatabaseService().getGames();
    debugPrint('Fetched ${gamesList.length} games');
    return {for (var game in gamesList) game.id: game};
  }

  String _formatDate(String date) {
    final dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _navigateToGameDetails(BuildContext context) {
    final exampleGame = Game(
      id: 0,
      name: 'Example Game',
      description: 'Description',
      imageUrl: 'assets/games.png',
      rating: 4.5,
      genre: 'Genre',
      year: 2021,
      developer: 'Developer',
      link: '',
      routines: [],
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailsScreen(game: exampleGame),
      ),
    );
  }

  void _navigateToProgress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressScreen(routines: routines, timerService: TimerService(() {})),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                _navigateToGameDetails(context);
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
                _navigateToProgress(context);
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
                      progressMap: progressMap,
                      routines: routines,
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
      body: FutureBuilder<List<History>>(
        future: _fetchHistory(),
        builder: (context, historySnapshot) {
          if (historySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (historySnapshot.hasError) {
            return Center(child: Text('Error: ${historySnapshot.error}'));
          } else if (!historySnapshot.hasData || historySnapshot.data!.isEmpty) {
            return const Center(child: Text('No hay historial disponible.'));
          } else {
            final historyList = historySnapshot.data!;
            return FutureBuilder<Map<int, Game>>(
              future: _fetchGames(),
              builder: (context, gamesSnapshot) {
                if (gamesSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (gamesSnapshot.hasError) {
                  return Center(child: Text('Error: ${gamesSnapshot.error}'));
                } else if (!gamesSnapshot.hasData || gamesSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay juegos disponibles.'));
                } else {
                  final games = gamesSnapshot.data!;
                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      final routine = routines.firstWhere(
                        (r) => r.id == history.routineId,
                        orElse: () => Routine(
                          id: 0,
                          name: 'Rutina Desconocida',
                          description: '',
                          objective: '',
                          steps: '',
                          expectedResults: '',
                          difficulty: '',
                          rating: 0,
                          gameId: 0,
                          imageUrl: '', 
                        ),
                      );
                      final game = games[routine.gameId] ?? Game(
                        id: 0,
                        name: 'Juego Desconocido',
                        description: '',
                        imageUrl: '',
                        rating: 0,
                        genre: '',
                        year: 0,
                        developer: '',
                        link: '',
                        routines: [],
                      );

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: game.imageUrl.isNotEmpty ? AssetImage(game.imageUrl) : null,
                            backgroundColor: Colors.blueAccent,
                            child: game.imageUrl.isEmpty ? const Icon(Icons.history, color: Colors.white) : null,
                          ),
                          title: Text(
                            'Descripción: ${history.description}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rutina: ${routine.name}'),
                              Text('Fecha: ${_formatDate(history.date)}'),
                              Text('Juego: ${game.name}'),
                            ],
                          ),
                          trailing: const Icon(Icons.touch_app), 
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
