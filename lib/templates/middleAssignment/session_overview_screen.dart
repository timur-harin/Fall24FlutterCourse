import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';
import 'active_session_screen.dart';

class SessionOverviewScreen extends ConsumerWidget {
  final String firstPhase;

  SessionOverviewScreen({required this.firstPhase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    int totalHotPhaseTime = session.phases
        .where((phase) => phase.phaseType == "hot")
        .fold(0, (sum, phase) => sum + phase.duration);
    int totalColdPhaseTime = session.phases
        .where((phase) => phase.phaseType == "cold")
        .fold(0, (sum, phase) => sum + phase.duration);

    int cycles = session.phases.length ~/ 2;
    int totalSessionDuration = totalHotPhaseTime + totalColdPhaseTime;

    String sessionType = firstPhase[0].toUpperCase() +
        firstPhase.substring(1) +
        '-' +
        (firstPhase == 'hot' ? 'Cold' : 'Hot');

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.red.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Session Overview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPhaseColumn(
                              context,
                              icon: Icons.local_fire_department,
                              label: 'Hot Phase',
                              value: '$totalHotPhaseTime sec',
                              color: Colors.redAccent,
                              phaseDuration: session.phases[0].duration,
                            ),
                            _buildPhaseColumn(
                              context,
                              icon: Icons.ac_unit,
                              label: 'Cold Phase',
                              value: '$totalColdPhaseTime sec',
                              color: Colors.blueAccent,
                              phaseDuration: session.phases[1].duration,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              Text(
                                'Total Session Time: $totalSessionDuration sec',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Session Type: $sessionType',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 220,
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
                            builder: (context) => ActiveSessionScreen(
                              session: session,
                              firstPhase: firstPhase,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Begin Session',
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
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseColumn(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required int phaseDuration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 60, color: color),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '$phaseDuration sec',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, color: Colors.white70, size: 18),
            SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
