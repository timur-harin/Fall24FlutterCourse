import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
    final counter = ref.watch(counterProvider); // Watch the counter state

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Exercise 1 - Perform an async operation using async/await
                  String result = await fetchData();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(result),
                    ),
                  );
                },
                child: Text('Async/Await Task'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Exercise 2 - Use Provider for state management (increment counter)
                  ref.read(counterProvider.notifier).state++; // Increment the counter
                },
                child: Text('Provider Task (Counter: $counter)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Exercise 3 - Use Riverpod for state management
                  ref.read(counterNotifierProvider.notifier).increment();
                },
                child: Text('Riverpod Task (Counter: ${ref.watch(counterNotifierProvider)})'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Exercise 4 - Make an HTTP request using the HTTP package
                  String result = await fetchHttpData();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(result),
                    ),
                  );
                },
                child: Text('HTTP Task'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                  String result = await fetchDioData();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(result),
                    ),
                  );
                },
                child: Text('Dio Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Exercise 1 - Perform async operation with async/await
Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body; // Return the JSON response
  } else {
    throw Exception('Failed to load data');
  }
}

// Exercise 4 - Fetch data using HTTP package
Future<String> fetchHttpData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body; // Return the JSON response
  } else {
    throw Exception('Failed to load data');
  }
}

// Exercise 5 - Fetch data using Dio package
Future<String> fetchDioData() async {
  try {
    var dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data.toString();
  } catch (e) {
    return 'Failed to fetch data: $e';
  }
}

// Provider for simple counter (Exercise 2)
final counterProvider = StateProvider<int>((ref) => 0);

// Exercise 3 - Using Riverpod StateNotifier for counter
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// StateNotifier class for Riverpod
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }

  void reset() {
    state = 0;
  }
}
