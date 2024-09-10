import 'dart:async';
import 'package:fall_24_flutter_course/templates/middleAssignment/components/history_notifier.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/components/temperature_painter.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemperatureTransitionWidget extends StatefulWidget {
  final double minTemperature; // Минимальная температура
  final double maxTemperature; // Максимальная температура
  final int totalDuration; // Общее время работы таймера
  final int phaseDuration;

  TemperatureTransitionWidget({
    required this.minTemperature,
    required this.maxTemperature,
    required this.totalDuration,
    required this.phaseDuration,
  });

  @override
  _TemperatureTransitionWidgetState createState() =>
      _TemperatureTransitionWidgetState();
}

class _TemperatureTransitionWidgetState
    extends State<TemperatureTransitionWidget> {
  Timer? _timer;
  int _secondsRemaining = 10;
  int _totalTimeRemaining = 0;
  bool _isTimerRunning = false;
  bool _isRed = true; // Флаг для текущего цвета
  bool _hasStarted = false;
  double _temperature = 0.0;
  Color _currentColor = Colors.red;
  int _phases = 0;

  @override
  void initState() {
    super.initState();
    _temperature = widget.maxTemperature;
    _totalTimeRemaining = widget.totalDuration;
    _secondsRemaining = widget.phaseDuration - 1;
  }

  void _startTimer() {
    _isTimerRunning = true;
    _hasStarted = true;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_isTimerRunning) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            // Меняем цвет и температуру
            if (_isRed) {
              // Переход к синему
              _currentColor = Colors.blue;
              _phases += 1;
              _temperature = widget.minTemperature;
              _secondsRemaining = widget.phaseDuration - 1; // Пауза 10 секунд на синем цвете
            } else {
              // Переход к красному
              _phases += 1;
              _currentColor = Colors.red;
              _temperature = widget.maxTemperature;
              _secondsRemaining = widget.phaseDuration - 1; // Пауза 10 секунд на красном цвете
            }

            _isRed = !_isRed; // Переключаем цвет
          }

          if (_totalTimeRemaining > 0) {
            _totalTimeRemaining--;
          } else {
            _isTimerRunning = false;
            _timer?.cancel();
            _endSession(context);
          }
        });
      }
    });
  }

  void _toggleTimer() {
    setState(() {
      if (_isTimerRunning) {
        // Останавливаем таймер
        _isTimerRunning = false;
        _timer?.cancel();
      } else {
        // Возобновляем таймер
        _secondsRemaining = widget.phaseDuration - 1;
        _totalTimeRemaining = widget.totalDuration;
        _temperature = widget.maxTemperature;
        _currentColor = Colors.red;
        _isRed = true;
        _startTimer();
      }
    });
  }

  void _stopTimer() {
     setState(() {
      if (_isTimerRunning) {
        // Останавливаем таймер
        _isTimerRunning = false;
        _timer?.cancel();
      }});
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _isTimerRunning = false;
      _secondsRemaining = widget.phaseDuration - 1;
      _totalTimeRemaining = widget.totalDuration;
      _temperature = widget.maxTemperature;
      _currentColor = Colors.red;
      _isRed = true;
      _hasStarted = false;
      _phases = 0;
    });
  }

  Future<void> _saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('duration', prefs.getInt('duration')! - _totalTimeRemaining);
    await prefs.setInt('phases', _phases);
  }

  void _endSession(BuildContext context) {
    _saveCurrentTime();
    _stopTimer();
    showDialog(context: context, builder: (BuildContext context) {
      return ConfirmDialog();
    });
    }
  
   @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(200, 200), // Устанавливаем размер виджета
                painter: TemperaturePainter(
                  temperature: _temperature,
                  color: _currentColor,
                ),
              ),
              Positioned(
                bottom: 10,
                child: Text(
                  '$_totalTimeRemaining s',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: _toggleTimer,
                  icon: _isTimerRunning
                      ? Icon(Icons.pause_circle)
                      : Icon(Icons.play_circle)),
              IconButton(
                  onPressed: _resetTimer, icon: Icon(Icons.restore_rounded)),
              IconButton(
                  onPressed: () => _endSession(context),
                  icon: Icon(Icons.stop_circle))
            ],
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
