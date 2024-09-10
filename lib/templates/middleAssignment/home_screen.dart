import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';
import 'session_detail_screen.dart';
import 'session_preferences_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(historyProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.red.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Contrast Shower Companion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: sessionHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shower,
                            size: 150,
                            color: Colors.white54,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "No sessions yet.",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: sessionHistory.length,
                      itemBuilder: (context, index) {
                        final session = sessionHistory[index];
                        final actualSessionDuration = session.phases.fold(
                            0, (sum, phase) => sum + phase.actualDuration);

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(
                              Icons.shower,
                              color: Colors.blueAccent,
                              size: 40,
                            ),
                            title: Text(
                              'Session on ${session.startTime}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Actual Duration: $actualSessionDuration seconds, Phases: ${session.phases.length}',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(height: 5),
                                if (session.rating > 0)
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < session.rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow,
                                        size: 20,
                                      );
                                    }),
                                  ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.info, color: Colors.blueAccent),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SessionDetailScreen(
                                      session: session,
                                      isManual: false,
                                      canRate: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.blue.shade400, width: 2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionPreferencesScreen(),
                    ),
                  );
                },
                child: Text(
                  'Start New Session',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
