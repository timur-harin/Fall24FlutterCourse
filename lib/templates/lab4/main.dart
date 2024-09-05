import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(ProviderScope(child: MyApp(),));
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
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Using DIO response:$result'),
                      );
                    },
                  );
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: const Text('Provider Task'),
            ),
            Text("counter ${ref.watch(counterProvider)}"),
            ElevatedButton(
              onPressed: () {              
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: const Text('Riverpod Task'),
            ),
            Text("counter ${ref.watch(counterNotifierProvider)}"),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Using HTTP response:${response.body}'),
                    );
                  }
                );
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode == 200) {
                  print('Dio Response: ${response.data}');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Using DIO response:${response.data}'),
                      );
                    },
                  );
                } else {
                  print('Failed to load data');
                }
              },
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}
