import 'package:flutter/material.dart';
//import 'package:fall_24_flutter_course/templates/middleAssignment/showersession.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/providers.dart';
import 'package:intl/intl.dart';

DateFormat _dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
String sessionToReadable(s) {
  return 'Taken ${_dateFormat.format(s.timeCompleted)} by scheme ${s.hotDuration}-${s.hotTemperature}-${s.coldDuration}-${s.coldTemperature}-${s.reps}';
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
        centerTitle: true,
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Text('Hello! How are you feeling today?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(historyProvider.notifier).reset();
                    /*ref.read(historyProvider.notifier).appendSession(
                      ShowerSession(hotDuration: 1, coldDuration: 1, hotTemperature: 1, coldTemperature: 1, reps: 1, timeCompleted: DateTime.now())
                    );*/
                  },
                  child: const Text('Clear sessions'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () { Navigator.pushNamed(context, '/settings'); },
                  child: const Text('New session'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Your session history:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8),
                children: history.map((s) => Text(sessionToReadable(s), textAlign: TextAlign.center, style: TextStyle(fontSize: 20))).toList().reversed.toList()
              )
            )
          ],
        )
      )
    );
  }
}