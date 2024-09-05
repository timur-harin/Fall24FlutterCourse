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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = Provider.of<CounterNotifier>(context);

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
                Text(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                counterNotifier.increment();
                counterNotifier.increment();
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read(counterProvider.notifier).state++;
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/2'));
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                final response = await dio
                    .get('https://jsonplaceholder.typicode.com/posts/3');
                Text(response.data.toString());
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
