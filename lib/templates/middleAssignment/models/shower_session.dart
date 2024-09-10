import 'dart:convert';
import 'package:mid_assignment/models/temperature_phase.dart';

class ShowerSession {
  final List<TemperaturePhase> phases;
  int totalTime;
  int completedPhases;
  double? rating;

  ShowerSession(
      {required this.phases,
      required this.totalTime,
      required this.completedPhases,
      this.rating});

  String toJson() => json.encode({
        'phases': phases.map((phase) => phase.toJson()).toList(),
        'totalTime': totalTime,
        'completedPhases': completedPhases,
        'rating': rating,
      });

  factory ShowerSession.fromJson(Map<String, dynamic> session) {
    final res = ShowerSession(
      phases: (session['phases'] as List)
          .map((phase) => TemperaturePhase.fromJson(phase))
          .toList(),
      totalTime: session['totalTime'],
      completedPhases: session['completedPhases'],
      rating: session['rating'],
    );
    return res;
  }
}
