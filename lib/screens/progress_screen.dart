import 'dart:async';
import 'dart:convert';
import 'package:e_sports_gamerstalca/routine_card.dart';
import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/timer_service.dart';
import 'package:e_sports_gamerstalca/models/routine.dart';
import 'package:e_sports_gamerstalca/models/history.dart';
import 'package:e_sports_gamerstalca/services/database_service.dart';
import 'package:e_sports_gamerstalca/screens/history_screen.dart';

class ProgressScreen extends StatefulWidget {
  final List<Routine> routines;
  final TimerService timerService;

  const ProgressScreen({
    super.key,
    required this.routines,
    required this.timerService,
  });

  @override
  ProgressScreenState createState() => ProgressScreenState();
}

class ProgressScreenState extends State<ProgressScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    setState(() {});
  }

  Future<void> _resetProgress(Routine routine) async {
    setState(() {
      final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;
      stepsMap.updateAll((key, value) => false);
      routine.updateSteps(stepsMap);
    });

    await _saveRoutineAndHistory(routine, 'Reset Progress');
  }

  Future<void> _resetPhase(Routine routine) async {
    setState(() {
      final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;
      final totalSteps = stepsMap.length;
      int stepsToReset = (totalSteps * 0.333).ceil();
      for (var entry in stepsMap.entries.toList().reversed) {
        if (entry.value && stepsToReset > 0) {
          stepsMap[entry.key] = false;
          stepsToReset--;
        }
      }
      routine.updateSteps(stepsMap);
    });

    await _saveRoutineAndHistory(routine, 'Reset Phase');
  }

  Future<void> _increaseProgress(Routine routine) async {
    setState(() {
      final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;
      for (var entry in stepsMap.entries) {
        if (!entry.value) {
          stepsMap[entry.key] = true;
          break;
        }
      }
      routine.updateSteps(stepsMap);
    });

    await _saveRoutineAndHistory(routine);
  }

  Future<void> _saveRoutineAndHistory(Routine routine, [String? description]) async {
    await DatabaseService().updateRoutine(routine);
    if (description != null && description.isNotEmpty) {
      final history = History(
        id: 0,
        routineId: routine.id,
        description: description,
        date: DateTime.now().toIso8601String(),
      );
      await DatabaseService().insertHistory(history);
    }
  }

  void _navigateToHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          progressMap: {for (var routine in widget.routines) routine.id: routine.progress},
          routines: widget.routines,
        ),
      ),
    );
  }

  Widget _buildRoutineCard(Routine routine) {
    return RoutineCard(
      routine: routine,
      progress: routine.progress,
      canSelectAgain: true,
      timeLeft: 0,
      onUpdateProgress: (updatedRoutine) {
        setState(() {
          final newSteps = (jsonDecode(updatedRoutine.steps) as Map<String, dynamic>).map((key, value) => MapEntry(key, true));
          updatedRoutine.updateSteps(newSteps);
        });
      },
      onIncreaseProgress: _increaseProgress,
      onResetProgress: _resetProgress,
      onResetPhase: _resetPhase,
      gameImageUrl: routine.imageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Initializing ProgressScreen with ${widget.routines.length} routines');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _navigateToHistory(context),
          ),
        ],
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
                Navigator.popAndPushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.gamepad),
              title: const Text(
                'Juegos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/details');
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text(
                'Progreso',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/progress');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Perfil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                'Historial',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'Información de Juegos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/gameInfo');
              },
            ),
          ],
        ),
      ),
      body: widget.routines.isEmpty
          ? const Center(child: Text('Sin rutinas'))
          : ListView.builder(
              itemCount: widget.routines.length,
              itemBuilder: (context, index) {
                final routine = widget.routines[index];
                return _buildRoutineCard(routine);
              },
            ),
    );
  }
}
