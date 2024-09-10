import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/shower_session.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/storage.dart';

class SessionSummaryScreen extends ConsumerStatefulWidget {
  final ShowerSession session;

  SessionSummaryScreen({required this.session});

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends ConsumerState<SessionSummaryScreen> {
  double _userRating = 0;

  @override
  Widget build(BuildContext context) {
    final totalPhases = widget.session.phases.length;
    final totalTime = widget.session.totalDuration.inMinutes;

    return Scaffold(
      appBar: AppBar(
        title: Text('session summary', style: TextStyle(fontSize: 40, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('total time: $totalTime minutes', style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
              SizedBox(height: 20),
              Text(
                'phases completed: $totalPhases', style: TextStyle(fontSize: 24, color: Colors.blueGrey)),
              SizedBox(height: 40),
              Text(
                'rate your experience:',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
              SizedBox(height: 20),
              RatingBar(
                initialRating: _userRating,
                onRatingUpdate: (rating) {
                  setState(() {
                    _userRating = rating;
                  });
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final localStorageService = LocalStorageService();
                  await localStorageService.saveSessionHistory([session]);
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: Text('finish', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double initialRating;
  final Function(double) onRatingUpdate;

  RatingBar({required this.initialRating, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    double rating = initialRating;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5,(index) => IconButton(
          icon: Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.amber),
          onPressed: () {
            rating = index + 1.0;
            onRatingUpdate(rating);
          },
        ),
      ),
    );
  }
}
