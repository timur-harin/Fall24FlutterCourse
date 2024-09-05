import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing counter state using StateProvider
    final counter = ref.watch(counterProvider);
    // Accessing the advanced counter state using StateNotifier
    final advancedCounter = ref.watch(counterNotifierProvider);
    // Accessing the HTTP response state
    final httpResponse = ref.watch(httpResponseProvider);
    // Accessing the Dio response state
    final dioResponse = ref.watch(dioResponseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider to increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task'),
            ),
            SizedBox(height: 10),
            Text('Counter Value: $counter'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Riverpod Task: Increment the advanced counter using Riverpod
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),
            SizedBox(height: 10),
            Text('Advanced Counter Value (Riverpod): $advancedCounter'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - HTTP Task: Make an HTTP request and update the state
                final data = await fetchData();
                ref.read(httpResponseProvider.notifier).state = data;
              },
              child: Text('HTTP Task'),
            ),
            SizedBox(height: 10),
            Text('HTTP Response Data:\n$httpResponse'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Dio Task: Make an HTTP request using Dio and update the state
                final data = await fetchDioData();
                ref.read(dioResponseProvider.notifier).state = data;
              },
              child: Text('Dio Task'),
            ),
            SizedBox(height: 10),
            Text('Dio Response Data:\n$dioResponse'),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // Fetching JSON data from URL
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  // Check if the request was successful
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data.toString();
  } else {
    return 'Failed to load data';
  }
}

// StateProvider for the counter
final counterProvider = StateProvider<int>((ref) => 0);

// StateProvider for HTTP response data
final httpResponseProvider = StateProvider<String>((ref) => '');

// StateProvider for Dio response data
final dioResponseProvider = StateProvider<String>((ref) => '');

// StateNotifier for the advanced counter
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() {
    state++;
  }
  void decrement() {
    state--;
  }
}

// Riverpod StateNotifierProvider for advanced counter
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

Future<String> fetchDioData() async {
  final dio = Dio();
  try {
    // Making a GET request using Dio
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    // Check if the request was successful
    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      return 'Failed to load data';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
