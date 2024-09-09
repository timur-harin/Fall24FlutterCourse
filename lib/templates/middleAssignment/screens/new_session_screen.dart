import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/active_session_screen.dart';

class NewSessionScreen extends StatefulWidget {
  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  Future<void> _saveNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int duration = int.parse(_controller1.text);
    double maxTemp = double.parse(_controller2.text);
    double minTemp = double.parse(_controller3.text);
    int phase_dur = int.parse(_controller4.text);
    await prefs.setInt('duration', duration);
    await prefs.setDouble('max_temp', maxTemp);
    await prefs.setDouble('min_temp', minTemp);
    await prefs.setInt('phase_dur', phase_dur);
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

  void _navigateToNextScreen() {
    int duration = int.parse(_controller1.text);
    double maxTemp = double.parse(_controller2.text);
    double minTemp = double.parse(_controller3.text);
    int phase_dur = int.parse(_controller4.text);

    if (maxTemp <= minTemp){
      _showDialog('Max temp should be greater min temp.');
    } else if (duration < 5) {
      _showDialog('Duration must be at least 5 seconds.');
    } else if (maxTemp <= 0 || minTemp <= 0) {
      _showDialog('Temperature must be greater than 0.');
    } else if (maxTemp > 55) {
      _showDialog('Max temperature cannot exceed 55°C.');
    } else if (phase_dur > duration - 3 || phase_dur < 0) {
      _showDialog('Phase time is invalid.');
    } else {
      _saveNumber().then((_) {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ActiveSessionScreen()), // Переход на главный экран
        (Route<dynamic> route) => false, // Условие удаления всех предыдущих маршрутов (false означает удалить все)
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Session'),
      ),
      body: Center(
        child: Padding(
              padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Set Your Preferences'),
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duration in seconds (min 5)',
                hintText: 'How long will you take a shower?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Max temperature',
                hintText: 'What is the maximum temperature?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Min temperature',
                hintText: 'What is the minimum temperature?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phase Duration',
                hintText: 'How long will take 1 phase (hot or cold)?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToNextScreen,
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 112, 22, 22), // Оранжевый цвет фона кнопки  // Круглая форма
              padding: EdgeInsets.all(40),
              minimumSize: Size(30, 30),  // Увеличенный размер кнопки
            ),
            child: Text(
              'Start New Session',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)), // Увеличение текста на кнопке
            ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
