import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';

import '../widgets/shower_session_history.dart';
import '../widgets/start_session_floating_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: 'Start Session',
        onPressed: () => context.pushRoute(const SessionPreferencesRoute()),
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
