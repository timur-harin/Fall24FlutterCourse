import 'package:fall_24_flutter_course/templates/middleAssignment/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Start new session'),
        centerTitle: true,
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Text('This is the Settings Page. Here you can adapt parameters as you wish.', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(270),
                1: FixedColumnWidth(100),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Hot phase time, seconds:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20)
                      )
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: TextEditingController(text: '${settings.hotDuration}'),
                        onChanged: (value) {
                          double? res = double.tryParse(value);
                          if(res != null) {
                            ref.read(settingsProvider).hotDuration = res;
                          }
                        },
                      )
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Hot phase temperature, C:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20)
                      )
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: TextEditingController(text: '${settings.hotTemperature}'),
                        onChanged: (value) {
                          double? res = double.tryParse(value);
                          if(res != null) {
                            ref.read(settingsProvider).hotTemperature = res;
                          }
                        },
                      )
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Cold phase time, seconds:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20)
                      )
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: TextEditingController(text: '${settings.coldDuration}'),
                        onChanged: (value) {
                          double? res = double.tryParse(value);
                          if(res != null) {
                            ref.read(settingsProvider).coldDuration = res;
                          }
                        },
                      )
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Cold phase temperature, C:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20)
                      )
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: TextEditingController(text: '${settings.coldTemperature}'),
                        onChanged: (value) {
                          double? res = double.tryParse(value);
                          if(res != null) {
                            ref.read(settingsProvider).coldTemperature = res;
                          }
                        },
                      )
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Number of repetitions:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20)
                      )
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: TextEditingController(text: '${settings.reps}'),
                        onChanged: (value) {
                          int? res = int.tryParse(value);
                          if(res != null) {
                            ref.read(settingsProvider).reps = res;
                          }
                        },
                      )
                    )
                  ]
                ),
              ]
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back to Home Page'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(settingsProvider.notifier).saveSettings();
                  },
                  child: Text('Set current settings as default'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(phaseElapsedProvider.notifier).restart();
                    Navigator.pushNamed(context, '/shower');
                  },
                  child: Text('Proceed'),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}


