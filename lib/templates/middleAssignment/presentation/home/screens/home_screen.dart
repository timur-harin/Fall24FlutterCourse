import 'package:flutter/material.dart';

import '../widgets/shower_session_history.dart';
import '../widgets/start_session_floating_button.dart';
import 'session_preferences_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ..._testData,
          const SliverToBoxAdapter(
            child: SizedBox(height: kShowerSessionHistoryHeight + 16.0),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StartSessionFloatingButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SessionPreferencesScreen(),
            ),
          );
        },
      ),
    );
  }

  List<Widget> get _testData => List.generate(
        32,
        (_) => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
              top: 8.0,
            ),
            child: ShowerSessionHistory(onPressed: () {}),
          ),
        ),
        growable: false,
      );
}
