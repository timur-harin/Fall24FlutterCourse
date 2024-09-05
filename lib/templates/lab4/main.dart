import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
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
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
                onPressed: () {
                  print('Provider Before:');
                  print(ref.read(counterProvider));
                  ref.read(counterProvider.notifier).state++;
                  print('Provider After:');
                  print(ref.read(counterProvider));
                },
                child: Text('Provider Task')),
            ElevatedButton(
              onPressed: () {
                print('Riverpod Before:');
                print(ref.watch(riverpodCounterProvider));
                ref.watch(riverpodCounterProvider.notifier).increment();
                print('Riverpod After:');
                print(ref.watch(riverpodCounterProvider));
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await http.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                print(response.body);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var dio = Dio();
                var response = await dio
                    .get('https://jsonplaceholder.typicode.com/posts/1');
                print(response.data);
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
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  return response.body;
}

final counterProvider = StateProvider<int>((ref) => 0);

final riverpodCounterProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}
