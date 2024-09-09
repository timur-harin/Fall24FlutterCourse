   import 'package:flutter/material.dart';
   import 'session_preferences_screen.dart';

   class HomeScreen extends StatelessWidget {
     const HomeScreen({super.key});

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: const Text('Contrast Shower Companion'),
         ),
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text('Welcome to the Contrast Shower Companion!'),
               ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const SessionPreferencesScreen(),
                     ),
                   );
                 },
                 child: const Text('Start New Session'),
               ),
             ],
           ),
         ),
       );
     }
   }
   
