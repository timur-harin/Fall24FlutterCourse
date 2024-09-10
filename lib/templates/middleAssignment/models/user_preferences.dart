class UserPreferences {
  late List<Duration> phaseDurations; // List of durations for each phase
  late int numberOfPhases;
  late bool isHotFirst;

  UserPreferences({
    required this.phaseDurations,
    required this.numberOfPhases,
    required this.isHotFirst,
  });
}
