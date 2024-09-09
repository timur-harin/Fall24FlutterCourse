import 'package:fall_24_flutter_course/templates/middleAssignment/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmDialog extends StatefulWidget{  
  @override
  _confirmDialogState createState() => _confirmDialogState();
}


class _confirmDialogState extends State<ConfirmDialog> {
  final TextEditingController _controller1 = TextEditingController();

  int _duration = 0;
  double _max_temp = 0;
  double _min_temp = 0;
  int _phases = 0;
  int  _phase_dur = 0;

  Future<void> _saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double experience = double.parse(_controller1.text);
    List<String> savedHistory = prefs.getStringList('saved_history') ?? [];
    savedHistory.add("Duration: ${prefs.getInt('duration')}, Max temp: ${prefs.getInt('max_temp')}, Min temp: ${prefs.getInt('min_temp')}, Phases: ${prefs.getInt('phases')}, Phase Duration: ${prefs.getInt('phase_dur')}, Experience: $experience");
    await prefs.setStringList('saved_history', savedHistory);
  }

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _duration = prefs.getInt('duration') ?? 0;
      _max_temp = prefs.getDouble('max_temp') ?? 0;
      _min_temp = prefs.getDouble('min_temp') ?? 0;
      _phases = prefs.getInt('phases') ?? 0;
      _phase_dur = prefs.getInt('phase_dur') ?? 0;
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _typeYes() {
    double experience = double.parse(_controller1.text);

    if (experience > 10 || experience < 0) {
      _showDialog('Type value from 0 to 10.');
    } else {
      _saveSession();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // Переход на главный экран
        (Route<dynamic> route) => false, // Условие удаления всех предыдущих маршрутов (false означает удалить все)
      );
    }
  }

  void _typeNo() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // Переход на главный экран
        (Route<dynamic> route) => false, // Условие удаления всех предыдущих маршрутов (false означает удалить все)
        );
  }

    @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: 
      Padding(padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Text("Save session?"),
            SizedBox(height: 20),
            Text("$_phases phases of $_phase_dur seconds"),
            SizedBox(height: 10),
            Text("Max/Min temperature: $_max_temp/$_min_temp"),
            SizedBox(height: 10),
            Text("Total duration: $_duration"),
            SizedBox(height: 20),
            TextField(
                controller: _controller1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'How it was? (out of 10)',
                  border: OutlineInputBorder(),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _typeYes,
                  child: const Text("Yes")
                  ),
                ElevatedButton(
                  onPressed: _typeNo,
                  child: Text('No')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
}