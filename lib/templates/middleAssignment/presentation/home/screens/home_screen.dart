import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/session_entity.dart';
import '../widgets/start_session_floating_button.dart';
import 'home_screen_notifier.dart';

const double kShowerSessionHistoryHeight = 64.0;

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loadingProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: state.loading == false
          ? _sessionHistory(context, state.sessions)
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Customize to match theme
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StartSessionFloatingButton(
        title: 'Start Session',
        onPressed: () => context.pushRoute(const SessionPreferencesRoute()),
      ),
    );
  }

  Widget _sessionHistory(
    BuildContext context,
    List<SessionEntity> sessions,
  ) {
    if (sessions.isEmpty) {
      return const Center(
        child: Text(
          'No session yet...',
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.pushRoute(
                        SessionDetailsRoute(
                          session: sessions[index],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Started With: ${sessions[index].startWithCold ? 'Cold' : 'Hot'}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Date: ${sessions[index].dateAndTime.day}/${sessions[index].dateAndTime.month}/${sessions[index].dateAndTime.year}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Duration: ${sessions[index].totalDuration.inSeconds.toString()}s',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,                           ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: sessions.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: kShowerSessionHistoryHeight + 16.0),
        )
      ],
    );
  }
}
