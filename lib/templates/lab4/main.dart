import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide Provider, ChangeNotifierProvider;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ChangeNotifierProvider(
          create: (_) => CounterNotifier(),
          child: MaterialApp(
            home: MyHomePage(),
          )),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterNotifier = Provider.of<CounterNotifier>(context);
    final counterProviderRiverprod = ref.watch(counterProvider);

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
                counterNotifier.increment();
                final int counterRN = counterNotifier.count;
                print('Counter from provider(provider): $counterRN');
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
                print(
                    'Counter from provider(riverprod): $counterProviderRiverprod');
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse(
                    'https://jsonplaceholder.typicode.com/comments/42'));
                print(response.body);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                final response = await dio
                    .get('https://jsonplaceholder.typicode.com/photos/224');
                // Map<String, dynamic> json = jsonDecode(response.data);
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
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  return response.body;
}

class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

final counterProvider = StateProvider<int>((ref) => 0);
