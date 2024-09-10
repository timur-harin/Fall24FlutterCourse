import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preferences_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_provider.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/storage.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/shower_session.dart';
import 'active_session_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ShowerSession> _sessionHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSessionHistory();
  }

  Future<void> _loadSessionHistory() async {
    final localStorageService = LocalStorageService();
    final history = await localStorageService.getSessionHistory();
    setState(() {
      _sessionHistory = history.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('contrast shower companion', style: TextStyle(fontSize: 40, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _sessionHistory.isEmpty
              ? Center(
                  child: const Text('no sessions found. start a new session!', style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                )
              : ListView.builder(
                  itemCount: _sessionHistory.length,
                  itemBuilder: (context, index) {
                    final session = _sessionHistory[index];
                    return ListTile(
                      title: Text('session on ${session.dateTime.toLocal()}', style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
                      subtitle: Text('total duration: ${session.totalDuration} minutes\nRating: ${session.rating ?? "Not Rated"}', style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
                      trailing: Text('Phases: ${session.phases.length}'),
                    );
                  },
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionPreferencesScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('start new session', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
