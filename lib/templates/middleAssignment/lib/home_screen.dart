import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'session_screen.dart';
import 'options_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MdiIcons.archive),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OptionsScreen()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Contrast Shower Companion',
          style: TextStyle(color: Color(0xFF6750A4)),
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.faceManProfile),
            onPressed: () {
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
            const SizedBox(height: 20),
            const Text(
              'Welcome back',
              style: TextStyle(
                color: Color(0xFF6750A4),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        daysOfWeek[index],
                        style: const TextStyle(
                            color: Color(0xFF6750A4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
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
            const SizedBox(height: 170),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(
                    100),
              ),
              child: const Text(
                'Start New Session',
                style: TextStyle(fontSize: 24, color: Color(0xFF6750A4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
