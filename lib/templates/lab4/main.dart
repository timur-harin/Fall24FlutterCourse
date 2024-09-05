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
    final counter = ref.watch(counterProvider);
    final riverpodCounter = ref.watch(counterNotifierProvider);
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
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task (Counter: $counter)'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task (Counter: $riverpodCounter)'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                print(response.body);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var dio = Dio();
                var response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
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
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  var jsonResponse = json.decode(response.body);
  return jsonResponse['title'] + '\n' + jsonResponse['body'];
}

final counterProvider = StateProvider<int>((ref) => 0);
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() {
    state++;
  }
}
