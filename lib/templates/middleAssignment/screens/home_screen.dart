import 'package:flutter/material.dart';
import 'package:mid_assignment/services/storage_service.dart';
import 'package:mid_assignment/models/shower_session.dart';
import 'package:mid_assignment/screens/session_preferences_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storageService = StorageService();
  late Future<List<ShowerSession>> _sessionsFuture;

  @override
  void initState() {
    super.initState();
    _sessionsFuture = _storageService.getSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ShowerSession>>(
              future: _sessionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final session = snapshot.data![index];
                      return ListTile(
                        title: Text('Session ${index + 1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating: ${session.rating}'),
                            Text('Duration: ${session.totalTime}')
                          ],
                        ),
                      );
                    },
                  );
                }
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
                      builder: (context) => SessionPreferencesScreen()),
                );
              },
              child: Text('Start new shower session'),
            ),
          ),
        ],
      ),
    );
  }
}
