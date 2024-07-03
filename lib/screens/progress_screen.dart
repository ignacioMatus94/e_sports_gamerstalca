import 'dart:convert';
import 'package:e_sports_gamerstalca/screens/history_screen.dart';
import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../routine_card.dart';
import '../timer_service.dart';
import '../services/database_service.dart';
import '../app_drawer.dart';

class ProgressScreen extends StatefulWidget {
  final List<Routine> routines;
  final TimerService timerService;

  const ProgressScreen({
    Key? key,
    required this.routines,
    required this.timerService,
  }) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Map<int, double> progressMap;
  late Map<int, int> timeLeftMap;
  late Map<int, bool> canSelectAgain;
  late Set<int> completionShown;
  late TimerService timerService;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _initializeProgressData();
  }

  Future<void> _initializeProgressData() async {
    progressMap = {for (var routine in widget.routines) routine.id: routine.progress};
    timeLeftMap = {for (var routine in widget.routines) routine.id: 0};
    canSelectAgain = {for (var routine in widget.routines) routine.id: false};
    completionShown = {};
    timerService = widget.timerService;
    timerService.startTimer(_updateAllProgress);
    setState(() {});
  }

  void _updateAllProgress() {
    bool anyProgressUpdated = false;
    bool allRoutinesCompleted = true;

    for (var routine in widget.routines) {
      if (_updateProgress(routine)) {
        anyProgressUpdated = true;
      }
      if (progressMap[routine.id] != 100.0) {
        allRoutinesCompleted = false;
      }
    }

    if (!anyProgressUpdated || allRoutinesCompleted) {
      timerService.stopTimer();
    }
  }

  bool _updateProgress(Routine routine) {
    final progress = progressMap[routine.id] ?? 0.0;
    final timeLeft = timeLeftMap[routine.id] ?? 0;

    if (timeLeft > 0) {
      timeLeftMap[routine.id] = timeLeft - 1;
    } else if (progress < 100.0) {
      canSelectAgain[routine.id] = true;
    }

    if (progress >= 100.0) {
      completionShown.add(routine.id);
    }

    setState(() {}); // Forzar la actualización de la UI
    debugPrint('Progress for routine ${routine.id} in ProgressScreen: $progress%');
    return progress < 100.0;
  }

  Future<void> _completeNextStep(Routine routine, double nextTarget) async {
    final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;
    final totalSteps = stepsMap.length;
    var completedSteps = stepsMap.values.where((value) => value).length;
    var currentProgress = totalSteps > 0 ? (completedSteps / totalSteps) * 100.0 : 0.0;

    while (currentProgress < nextTarget) {
      final nextStep = stepsMap.entries.firstWhere((entry) => !entry.value, orElse: () => MapEntry('', false));
      if (nextStep.key.isNotEmpty) {
        stepsMap[nextStep.key] = true;
        completedSteps++;
        currentProgress = (completedSteps / totalSteps) * 100.0;
        routine.updateSteps(stepsMap); // Utilizar el método updateSteps
      }
    }
    progressMap[routine.id] = currentProgress;
    routine.selectedAt = DateTime.now().toIso8601String();
    canSelectAgain[routine.id] = nextTarget < 100.0;

    setState(() {
      debugPrint('Progress updated for routine ${routine.id} to $nextTarget% in ProgressScreen');
    });

    // Guardar la rutina actualizada en la base de datos
    await _databaseService.updateRoutine(routine);

    if (nextTarget < 100.0) {
      timerService.resetTimer(15);
      debugPrint('Timer reset at $nextTarget% for routine ${routine.id}');
    } else {
      bool allRoutinesCompleted = true;
      for (var r in widget.routines) {
        if (progressMap[r.id] != 100.0) {
          allRoutinesCompleted = false;
          break;
        }
      }
      if (allRoutinesCompleted) {
        timerService.stopTimer();
      }
      debugPrint('Timer checked for all routines at $nextTarget% for routine ${routine.id}');
    }
  }

  void _navigateToHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          progressMap: progressMap,
          routines: widget.routines,
        ),
      ),
    );
  }

  String _getGameImage(int gameId) {
    switch (gameId) {
      case 1:
        return 'assets/mario.png';
      case 2:
        return 'assets/rayman.png';
      case 3:
        return 'assets/starcraft.png';
      case 4:
        return 'assets/pacman.png';
      default:
        return 'assets/games.png';
    }
  }

  @override
  void dispose() {
    timerService.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _navigateToHistoryScreen,
          ),
        ],
      ),
      drawer: AppDrawer(), // Agregar el Drawer aquí
      body: ListView.builder(
        itemCount: widget.routines.length,
        itemBuilder: (context, index) {
          final routine = widget.routines[index];
          final progress = progressMap[routine.id] ?? 0.0;
          final timeLeft = timeLeftMap[routine.id] ?? 0;
          final gameImageUrl = _getGameImage(routine.gameId);
          return RoutineCard(
            routine: routine,
            progress: progress,
            canSelectAgain: canSelectAgain[routine.id] ?? false,
            timeLeft: timeLeft,
            onUpdateProgress: _updateProgress,
            onNextPhase: (routine) => _completeNextStep(routine, progress + 33.0), // Lógica para avanzar a la siguiente fase
            gameImageUrl: gameImageUrl,
          );
        },
      ),
    );
  }
}
