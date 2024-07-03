import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/game_details_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/history_screen.dart';
import 'screens/game_info.dart';
import 'models/game.dart';
import 'timer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DatabaseService().initializeDatabase();
    debugPrint('Database initialized successfully');
  } catch (error) {
    debugPrint('Error initializing database: $error');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E_SPORTS_GAMERSTALCA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/progress': (context) => ProgressScreen(routines: [], timerService: TimerService(() {})),
        '/details': (context) => GameDetailsScreen(game: Game(
            id: 0, 
            name: 'Example Game', 
            description: 'Description', 
            imageUrl: 'assets/games.png', 
            rating: 4.5, 
            genre: 'Genre', 
            year: 2021, 
            developer: 'Developer', link: '')),
        '/profile': (context) => const ProfileScreen(),
        '/history': (context) => HistoryScreen(progressMap: {}, routines: []),
        '/gameInfo': (context) => const GameInfoScreen(),
      },
    );
  }
}
