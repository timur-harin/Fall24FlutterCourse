import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartSessionButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: Text('Start New Session'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/preferences');
        },
      ),
    );
  }
}
