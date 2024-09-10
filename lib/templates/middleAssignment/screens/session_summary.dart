import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/shower_session.dart';
import '../providers/session_provider.dart';

class SessionSummaryScreen extends StatefulWidget {
  final ShowerSession session;
  final int sessionKey;

  const SessionSummaryScreen({super.key, required this.session, required this.sessionKey});

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  int? selectedRating;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.session.rating;
  }

  Future<void> _saveRating(int rating, WidgetRef ref) async {
    var box = await Hive.openBox<ShowerSession>('session_history');
    
    final updatedSession = widget.session.copyWith(rating: rating);
    await box.put(widget.sessionKey, updatedSession);
    ref.read(sessionHistoryProvider.notifier).updateSession(widget.sessionKey, updatedSession);

    setState(() {
      selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Summary',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              widget.session.dateTime.toString().split(' ')[0],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.black54, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.session.totalDuration} s',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Phases',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: widget.session.phases.map((phase) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    phase.type,
                                    style: TextStyle(fontSize: 16, color: phase.type == 'HOT' ? Colors.orange : Colors.blue),
                                  ),
                                  Text(
                                    '${phase.duration} s',
                                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    const Text(
                      'Rate your experience:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.sentiment_very_dissatisfied, size: 40),
                          color: selectedRating == 1 ? Colors.red : Colors.grey,
                          onPressed: () => _saveRating(1, ref),
                        ),
                        IconButton(
                          icon: const Icon(Icons.sentiment_neutral, size: 40),
                          color: selectedRating == 2 ? Colors.yellow : Colors.grey,
                          onPressed: () => _saveRating(2, ref),
                        ),
                        IconButton(
                          icon: const Icon(Icons.sentiment_very_satisfied, size: 40),
                          color: selectedRating == 3 ? Colors.green : Colors.grey,
                          onPressed: () => _saveRating(3, ref),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
