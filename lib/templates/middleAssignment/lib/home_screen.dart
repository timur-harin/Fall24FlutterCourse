import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'session_screen.dart';
import 'options_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of days for the week
    final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MdiIcons.archive),
          onPressed: () {
            // Navigate to the options panel
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OptionsScreen()),
            );
          },
        ),
        centerTitle: true, // Centers the title
        title: Text('Contrast Shower Companion'),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.faceManProfile),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Padding from top
            const Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 24, // 24pt font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50), // Spacing between "Welcome back" and the progress
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        daysOfWeek[index], // Display day names above each circle
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5), // Small spacing between text and the circle
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: index < 5 ? Colors.green : Colors.grey,
                        child: index < 5
                            ? Icon(MdiIcons.check, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 170),
            // Space between progress and the button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(100), // Adjust the padding to make a big circle button
              ),
              child: Text(
                'Start New Session',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
