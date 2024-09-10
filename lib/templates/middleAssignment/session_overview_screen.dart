import 'package:flutter/material.dart';
import 'active_session_screen.dart';

class SessionOverviewScreen extends StatelessWidget {
  final int hotDuration;
  final int coldDuration;

  const SessionOverviewScreen({Key? key, this.hotDuration = 60, this.coldDuration = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Session Overview')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(16.0), child: Text('Hot Duration: $hotDuration min', style: TextStyle(fontSize: 20.0, color: Colors.red),),),
            Text('Cold Duration: $coldDuration min', style: TextStyle(fontSize: 20.0, color: Colors.blue),),
            Padding(padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      hotDuration: hotDuration,
                      coldDuration: coldDuration,
                    ),
                  ),
                );
              },
              child: Text('Begin Session'),
            ),)
            
          ],
        ),
      ),
    );
  }
}
