import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'home_screen.dart';
import 'session_provider.dart';

class SessionDetailScreen extends ConsumerStatefulWidget {
  final ShowerSession session;
  final bool isManual;
  final bool canRate;

  SessionDetailScreen({
    required this.session,
    required this.isManual,
    this.canRate = false,
  });

  @override
  _SessionDetailScreenState createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends ConsumerState<SessionDetailScreen> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.session.rating;
  }

  @override
  Widget build(BuildContext context) {
    final filteredPhases = widget.session.phases
        .where((phase) => phase.actualDuration > 0)
        .toList();

    final int actualSessionDuration =
        filteredPhases.fold(0, (sum, phase) => sum + phase.actualDuration);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Session Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            if (widget.isManual)
              Text(
                'Session ended manually',
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:
                    Icon(Icons.timer, color: Colors.orangeAccent, size: 40),
                title: Text(
                  'Total Intended Duration: ${widget.session.duration} seconds',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Actual Duration: $actualSessionDuration seconds',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Phases:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPhases.length,
                itemBuilder: (context, index) {
                  final phase = filteredPhases[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        phase.phaseType == "hot"
                            ? Icons.local_fire_department
                            : Icons.ac_unit,
                        color: phase.phaseType == "hot"
                            ? Colors.redAccent
                            : Colors.blueAccent,
                        size: 40,
                      ),
                      title: Text(
                        '${phase.phaseType} phase',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Actual Duration: ${phase.actualDuration} seconds',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Rating',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        _rating > index ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      onPressed: widget.canRate
                          ? () {
                              setState(() {
                                _rating = index + 1;
                              });
                            }
                          : null,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.home, color: Colors.blue.shade400),
                onPressed: () {
                  if (widget.canRate) {
                    final updatedSession =
                        widget.session.copyWith(rating: _rating);
                    ref
                        .read(historyProvider.notifier)
                        .updateSession(updatedSession);
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                label: Text(
                  widget.canRate
                      ? 'Submit Rating and Go to Home'
                      : 'Go to Home',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.blue.shade400, width: 2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
