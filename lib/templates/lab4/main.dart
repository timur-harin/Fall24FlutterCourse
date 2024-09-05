// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider, Provider;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CounterModel(),
    child: MyApp(),
    ),
  );
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
    final counter = ref.watch(counterRiverpod);
    var counter_provider = Provider.of<CounterModel>(context);

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
                  builder: (context) => AlertDialog(
                    title: const Text('Fetched Data'),
                    content: SingleChildScrollView(child: Text(result)),
                    actions: <Widget>[
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      child: const Text('Close'))
                    ],
                  )
                );
              },
              child: const Text('Async/Await Task'),
            ),
            Text("Provider state counter: ${counter_provider.counter}"),
            ElevatedButton(
              onPressed: () { 
                counter_provider.incrementCounter();
              },
              child: const Text('Provider Task'),
            ),
            Text("Riverpod state counter: ${ref.read(counterRiverpod.notifier).state}"),
            ElevatedButton(
              onPressed: () { 
                ref.read(counterRiverpod.notifier).state++;
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final number = Random().nextInt(4) + 1;
                final response = await http.get(Uri.parse('https://swapi.dev/api/films/$number/'));
                final film = jsonDecode(response.body) as Map<String, dynamic>;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Random Film Data'),
                    content: SingleChildScrollView(child: Text(film["opening_crawl"])),
                    actions: <Widget>[
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      child: const Text('Close'))
                    ],
                  )
                );
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchDataDio();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Fetched Data'),
                    content: SingleChildScrollView(child: Text(result)),
                    actions: <Widget>[
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      child: const Text('Close'))
                    ],
                  )
                );
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
    throw Exception('Failed to get data from url');
  }
}

Future<String> fetchDataDio() async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/3');

  if (response.statusCode == 200) {
    return response.data.toString();
  } else {
    throw Exception('Failed to load data');
  }
}

final counterRiverpod = StateProvider<int>((ref) => 0);

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
