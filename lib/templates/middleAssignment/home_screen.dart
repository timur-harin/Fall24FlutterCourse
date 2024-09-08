import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'session_provider.dart';


class HomeScreen extends ConsumerWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref){
    final showerSessions = ref.watch(showerSessionProvider);



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contrast Shower Companion', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded (
            child: ListView.builder(
              itemCount: showerSessions.length,
              itemBuilder: (context, index){
                final session = showerSessions[index];
                return ListTile(
                  title: Text('Session on ${session.date}', style: const TextStyle(color: Colors.white)),
                  subtitle: Text('Duration: ${session.duration} mins, Rating: ${session.rating} stars', style: const TextStyle(color: Colors.white54)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF58D0FE), Color(0xFFEE7752)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SessionPreferencesScreen()),
                  );
                },
                child: const Text(
                  'Start New Session',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
}