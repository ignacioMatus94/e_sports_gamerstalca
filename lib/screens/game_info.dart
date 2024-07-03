import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/screens/game_details_screen.dart';
import '../models/game.dart';
import '../services/database_service.dart';
import '../app_drawer.dart'; // Asegúrate de importar AppDrawer
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher

class GameInfoScreen extends StatefulWidget {
  const GameInfoScreen({super.key});

  @override
  GameInfoScreenState createState() => GameInfoScreenState();
}

class GameInfoScreenState extends State<GameInfoScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final List<Game> _games = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final games = await _databaseService.getGames(limit: 4, offset: 0);
      setState(() {
        _games.addAll(games);
      });
      for (var game in games) {
        debugPrint('Loaded game: ${game.name}');
      }
      debugPrint('Games loaded: ${_games.length}');
    } catch (error) {
      debugPrint('Error loading games: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  String? getGameUrl(String gameName) {
    switch (gameName.toLowerCase().trim()) {
      case 'super mario':
        return 'https://mario.nintendo.com/es/';
      case 'starcraft':
        return 'https://starcraft2.blizzard.com/';
      case 'pacman':
        return 'https://www.pacman.com/en/';
      case 'rayman':
        return 'https://www.ubisoft.com/es-es/game/rayman/origins';
      default:
        return null; // No returns a default URL
    }
  }

  Widget _buildGameCard(Game game) {
    final gameUrl = getGameUrl(game.name);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ExpansionTile(
        title: Text(
          game.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 5),
            Text('${game.rating}', style: const TextStyle(fontSize: 14)),
          ],
        ),
        leading: Image.asset(
          game.imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Descripción'),
            subtitle: Text(game.description),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Género'),
            subtitle: Text(game.genre),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Año'),
            subtitle: Text(game.year.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.developer_mode),
            title: const Text('Desarrollador'),
            subtitle: Text(game.developer),
          ),
          // Agrega un botón para navegar a los detalles del juego
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Ver Detalles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailsScreen(game: game),
                ),
              );
            },
          ),
          // Agrega un botón para abrir el enlace del juego si existe
          if (gameUrl != null)
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Enlace del Juego'),
              subtitle: InkWell(
                child: Text(
                  gameUrl,
                  style: const TextStyle(color: Colors.blue),
                ),
                onTap: () => _launchURL(gameUrl),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Juegos'),
      ),
      drawer: AppDrawer(), // Agregar el Drawer aquí
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _games.length,
              itemBuilder: (context, index) {
                final game = _games[index];
                return _buildGameCard(game);
              },
            ),
    );
  }
}
