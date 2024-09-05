import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
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
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                //check fetchData
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(ref.read(counterProvider.notifier).state.toString()),
                  ),
                );
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterNotifierProvider.notifier).increment();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                    content: Text(ref.watch(counterNotifierProvider).toString()),
                ),
                );
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 4 - Make an HTTP request using the HTTP package
                final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
                final response = await http.get(url);

                if (response.statusCode == 200) {
                  final data = response.body;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(data),
                    ),
                  );
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/albums/1');

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(response.data.toString()),
                  ),
                );
              },
              child: Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() {
    state += 1;
  }
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
