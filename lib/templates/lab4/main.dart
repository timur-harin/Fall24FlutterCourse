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
    final counterProvider = ref.watch(providerCounter);
    final counterRiverpod = ref.watch(riverpodCounterProvider);
    final dioResponse = ref.watch(dioProvider);

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
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                ref.read(providerCounter.notifier).state++;
              },
              child: Text('Provider Task: $counterProvider'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Use Riverpod for state management
                ref.read(riverpodCounterProvider.notifier).increment();
              },
              child: Text('Riverpod Task: $counterRiverpod'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(response.body),
                    ),
                  );
                } else {
                  print('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(dioProvider.notifier).state = response.data.toString();
              },
              child: Text('Dio Task'),
            ),
            if (dioResponse.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Dio Response: $dioResponse'),
              )
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // Fetch data from a URL and return it as a string
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

class RiverpodCounter extends StateNotifier<int> {
  RiverpodCounter() : super(0);

  void increment() => state++;
}

final providerCounter = StateProvider<int>((ref) => 0);
final riverpodCounterProvider = StateNotifierProvider<RiverpodCounter, int>((ref) => RiverpodCounter());
final dioProvider = StateProvider<String>((ref) => '');
