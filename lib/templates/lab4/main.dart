import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    final counter = ref.watch(counterProvider);
    final counter2 = ref.watch(CounterNotifierProvider);
    final dioResult = ref.watch(dioResultProvider);

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
                print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task (Counter) $counter'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(CounterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task (Counter) $counter2'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/2'));
                if (response.statusCode == 200) {
                  print(json.decode(response.body).toString());
                } else {
                  print('Failed to get json');
                }
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var dio = Dio();
                final response = await dio
                    .get('https://jsonplaceholder.typicode.com/posts/3');
                ref.read(dioResultProvider.notifier).state =
                    response.data.toString();
              },
              child: Text('Dio Result $dioResult'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return json.decode(response.body).toString();
  } else {
    return 'Failed to get json';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final CounterNotifierProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

final dioResultProvider =
    StateProvider<String>((ref) => 'No data fetched yet with Dio');
