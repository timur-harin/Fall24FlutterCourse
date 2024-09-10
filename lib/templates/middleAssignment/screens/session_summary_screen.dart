import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mid_assignment/models/shower_session.dart';
import 'package:mid_assignment/screens/home_screen.dart';
import 'package:mid_assignment/services/storage_service.dart';

class SessionSummaryScreen extends StatefulWidget {
  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  final _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    final ShowerSession session =
        ModalRoute.of(context)!.settings.arguments as ShowerSession;

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Total time: ${session.totalTime} minutes'),
            Text('Completed phases: ${session.completedPhases}'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: session.phases.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Phase ${index + 1}'),
                  subtitle: Text(
                      'Type: ${session.phases[index].phaseType}, Duration: ${session.phases[index].duration} minutes'),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Rate your experience:'),
            RatingBar.builder(
              initialRating: session.rating ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  session.rating = rating;
                });
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _storageService.saveSession(session);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
