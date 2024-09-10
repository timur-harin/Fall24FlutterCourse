import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'shower_session.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Previous Sessions'),
      ),
      body: FutureBuilder<List<ShowerSession>>(
        future: _fetchSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching sessions'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No previous sessions found.'));
          } else {
            final sessions = snapshot.data!;

            return ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ListTile(
                  title: Text('Session ${index + 1}'),
                  subtitle: Text('Date: ${session.date}\nDuration: '
                      '${session.totalDuration} seconds'),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<ShowerSession>> _fetchSessions() async {
    final box = await Hive.openBox<ShowerSession>('sessionsBox');
    final sessions = box.values.toList();
    await box.close();

    return sessions;
  }
}
