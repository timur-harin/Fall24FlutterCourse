import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final sessionDurationProvider = StateProvider<int>((ref) => 10);
final hotPhaseDurationProvider = StateProvider<int>((ref) => 1);
final coldPhaseDurationProvider = StateProvider<int>((ref) => 1);

class ShowerSession {
  final int duration;
  final int phasesCompleted;
  final int rating;

  ShowerSession({
    required this.duration,
    required this.phasesCompleted,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'phasesCompleted': phasesCompleted,
      'rating': rating,
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      duration: map['duration'],
      phasesCompleted: map['phasesCompleted'],
      rating: map['rating'],
    );
  }
}

class SessionStorageService {
  static const String sessionHistoryKey = 'sessionHistory';

  Future<void> saveSession(ShowerSession session) async {
    final prefs = await SharedPreferences.getInstance();

    final String? history = prefs.getString(sessionHistoryKey);
    List<Map<String, dynamic>> sessionList = history != null
        ? List<Map<String, dynamic>>.from(
            (await prefs.getStringList(sessionHistoryKey))!
                .map((e) => Map<String, dynamic>.from(e as Map)))
        : [];

    sessionList.insert(0, session.toMap());
    await prefs.setString(sessionHistoryKey, sessionList.toString());
  }

  Future<List<ShowerSession>> loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? history = prefs.getString(sessionHistoryKey);

    if (history != null) {
      List<Map<String, dynamic>> sessionList = List<Map<String, dynamic>>.from(
          (await prefs.getStringList(sessionHistoryKey))!
              .map((e) => Map<String, dynamic>.from(e as Map)));

      return sessionList.map((sessionMap) {
        return ShowerSession.fromMap(sessionMap);
      }).toList();
    }
    return [];
  }
}

final sessionHistoryProvider = StateProvider<List<ShowerSession>>((ref) => [
]);

class HomeScreen extends ConsumerStatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = context.read(sessionHistoryProvider as StateProvider<int>).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: sessionHistory.isEmpty
                ? Center(
                    child: Text(
                      'No session history',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: sessionHistory.length,
                    itemBuilder: (context, index) {
                      final session = sessionHistory[index];
                      return ListTile(
                        title: Text('Session on ${session.date.toLocal()}'),
                        subtitle: Text('Duration: ${session.duration}'),
                        leading: Icon(Icons.shower, color: Colors.blueAccent),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SessionSetupScreen()));
        },
        label: Text('Start new session'),
        icon: Icon(Icons.play_arrow),
        backgroundColor: Colors.lightBlue[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<ShowerSession>> _sessionHistoryFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    setState(() {
      _sessionHistoryFuture = SessionStorageService().loadSessionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contrast Shower Companion')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SessionSetupScreen(),
                ),
              ).then((_) {
                _loadHistory();
              });
            },
            child: Text('Start new session'),
          ),
          SizedBox(height: 20),

          Expanded(
            child: FutureBuilder<List<ShowerSession>>(
              future: _sessionHistoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No session history'));
                }

                final List<ShowerSession> history = snapshot.data!;
                return ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final session = history[index];
                    return ListTile(
                      title: Text('Session ${index + 1}'),
                      subtitle: Text(
                          'Duration: ${_formatTime(session.duration)}, Phases: ${session.phasesCompleted}, Rating: ${session.rating}/5'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class SessionSetupScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionDuration = ref.read(sessionDurationProvider);
    final hotPhaseDuration = ref.read(hotPhaseDurationProvider);
    final coldPhaseDuration = ref.read(coldPhaseDurationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create new session'),
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Session duration: $sessionDuration mins', style: TextStyle(fontSize: 18)),
            Slider(
              value: sessionDuration.toDouble(),
              min: 5,
              max: 30,
              divisions: 25,
              label: "$sessionDuration min",
              onChanged: (value) {
                ref.read(sessionDurationProvider).state = value.toInt();
              },
            ),
            SizedBox(height: 20),

            Text('Hot phase duration: $hotPhaseDuration mins', style: TextStyle(fontSize: 18)),
            Slider(
              value: hotPhaseDuration.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: "$hotPhaseDuration min",
              onChanged: (value) {
                ref.read(hotPhaseDurationProvider).state = value.toInt();
              },
            ),
            SizedBox(height: 20),

            Text('Cold phase duration: $coldPhaseDuration mins', style: TextStyle(fontSize: 18)),
            Slider(
              value: coldPhaseDuration.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: "$coldPhaseDuration min",
              onChanged: (value) {
                ref.read(coldPhaseDurationProvider).state = value.toInt();
              },
            ),
            SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SessionOverviewScreen()));
                },
                child: Text('Session overview'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), backgroundColor: Colors.lightBlue[700],
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on int {
  set state(int state) {}
}

class SessionOverviewScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionDuration = ref.read(sessionDurationProvider);
    final hotPhaseDuration = ref.read(hotPhaseDurationProvider);
    final coldPhaseDuration = ref.read(coldPhaseDurationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session overview'),
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Session duration: $sessionDuration mins', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            Text('Hot phase duration: $hotPhaseDuration mins', style: TextStyle(fontSize: 16)),
            Text('Cold phase duration: $coldPhaseDuration mins', style: TextStyle(fontSize: 16)),
            SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveSessionScreen()));
                },
                child: Text('Begin session'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), backgroundColor: Colors.lightBlue[700],
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  Timer? _timer;
  bool _isHotPhase = true;
  bool _isPaused = false;
  int _timeRemaining = 0;
  int _currentSessionTime = 0;
  int _totalSessionTime = 0;
  AudioPlayer _audioPlayer = AudioPlayer();

  void _switchPhase() {
    setState(() {
      _isHotPhase = !_isHotPhase;
      _timeRemaining = (_isHotPhase
          ? context.read(hotPhaseDurationProvider).state * 60
          : context.read(coldPhaseDurationProvider).state * 60);
    });
  }

  @override
  void initState() {
    super.initState();
    _startSession();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _pauseSession() {
    setState(() {
      _isPaused = true;
      _timer?.cancel();
    });
  }

  void _startSession() {
    setState(() {
      _isHotPhase = true;
      _isPaused = false;
      _timeRemaining = context.read(hotPhaseDurationProvider).state * 60;
      _totalSessionTime = context.read(sessionDurationProvider).state * 60;
      _startTimer();
    });
  }

    void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
          _currentSessionTime++;
        } else {
          _switchPhase();
        }

        if (_currentSessionTime >= _totalSessionTime) {
          _endSession();
        }
      });
    });
  }

  void _resumeSession() {
    setState(() {
      _isPaused = false;
      _startTimer();
    });
  }

  void _stopSession() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  void _endSession() {
    _timer?.cancel();
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => SessionSummaryScreen(
        totalSessionTime: _currentSessionTime,
        phasesCompleted: _isHotPhase
            ? _currentSessionTime ~/ context.read(hotPhaseDurationProvider).state
            : _currentSessionTime ~/ context.read(coldPhaseDurationProvider).state,
        onSave: _saveSessionToHistory,
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Session complete'),
          content: Text('Your shower session is complete'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  void _saveSessionToHistory(int rating) async  {
    final session = ShowerSession(
      duration: _currentSessionTime,
      phasesCompleted: _isHotPhase
          ? _currentSessionTime ~/ context.read(hotPhaseDurationProvider).state
          : _currentSessionTime ~/ context.read(coldPhaseDurationProvider).state,
      rating: rating,
    );

    await SessionStorageService().saveSession(session);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
          _currentSessionTime++;
        } else {
          _playPhaseChangeSound();
          _switchPhase();

          if (_isHotPhase) {
            _isHotPhase = false;
            _timeRemaining = context.read(coldPhaseDurationProvider).state * 60;
          } else {
            _isHotPhase = true;
            _timeRemaining = context.read(hotPhaseDurationProvider).state * 60;
          }
        }

        if (_currentSessionTime >= _totalSessionTime) {
          _timer?.cancel();
          _showSessionCompleteDialog();
          _endSession();
        }
      });
    });
  }

  void _playPhaseChangeSound() async {
    // await _audioPlayer.play(AssetSource('transition.mp3'));
  }

  void _showSessionCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Session complete'),
          content: Text('Your shower session is complete'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _isHotPhase ? Colors.red[400] : Colors.blue[400],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isHotPhase ? 'Hot phase' : 'Cold phase',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 20),
              
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _timeRemaining / (_isHotPhase
                        ? context.read(hotPhaseDurationProvider).state * 60
                        : context.read(coldPhaseDurationProvider).state * 60),
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Text(
                    '${(_timeRemaining ~/ 60).toString().padLeft(2, '0')}:${(_timeRemaining % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isPaused ? _resumeSession : _pauseSession,
                    child: Text(_isPaused ? 'Resume' : 'Pause'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopSession,
                    child: Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  read(StateProvider<int> coldPhaseDurationProvider) {}
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  WavePainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height * 0.5 + sin((i + animationValue) / 20) * 20,
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class WaveTransitionAnimation extends StatefulWidget  {
  final bool isHotPhase;

  WaveTransitionAnimation({required this.isHotPhase});

  @override
  _WaveTransitionAnimationState createState() => _WaveTransitionAnimationState();
}

class _WaveTransitionAnimationState extends State<WaveTransitionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(
            _controller.value * 360,
            widget.isHotPhase ? Colors.red : Colors.blue,
          ),
          child: Container(),
        );
      },
    );
  }
}

class SessionSummaryScreen extends StatelessWidget {
  final int totalSessionTime;
  final int phasesCompleted;
  final void Function(int rating) onSave;

  SessionSummaryScreen({
    required this.totalSessionTime,
    required this.phasesCompleted,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session summary'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total time: ${_formatTime(totalSessionTime)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Text(
              'Phases completed: $phasesCompleted',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            Text(
              'Rate your experience:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RatingWidget(onRate: onSave),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class RatingWidget extends StatefulWidget {
  final void Function(int rating) onRate;

  RatingWidget({required this.onRate});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1;
            });
            widget.onRate(_currentRating);
          },
        );
      }),
    );
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}