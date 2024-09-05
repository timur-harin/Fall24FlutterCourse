import 'dart:convert';
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
                print('Fetching data...');
                String fetchedData = await fetchData();
                print('Data fetched: $fetchedData');
                ref.read(jsonState.notifier).state = fetchedData;
              },
              child: Text('Async/Await Task'),
            ),
            Text(ref.watch(jsonState).isEmpty ? 'No data yet' : ref.watch(jsonState)), // Placeholder text

            ElevatedButton(
              onPressed: () => ref.read(counterState.notifier).state++,
              child: Text('Provider Task = ${ref.watch(counterState)}'),
            ),

            ElevatedButton(
              onPressed: () => ref.read(riverpodCounterState.notifier).incrementCounter(),
              child: Text('Riverpod Task = ${ref.watch(riverpodCounterState)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('Making HTTP request...');
                String httpResponse = await fetchData();
                print('HTTP Response: $httpResponse');
                ref.read(httpResponseState.notifier).state = httpResponse;
              },
              child: Text('HTTP Task'),
            ),
            Text(ref.watch(httpResponseState).isEmpty ? 'No HTTP response' : ref.watch(httpResponseState)),

            ElevatedButton(
              onPressed: () async {
                print('Making Dio request...');
                try {
                  Response dioResponse = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                  print('Dio Response: ${dioResponse.data}');
                  ref.read(dioResponseState.notifier).state = dioResponse.toString();
                } catch (e) {
                  print('Error with Dio: $e');
                  ref.read(dioResponseState.notifier).state = 'Error: $e';
                }
              },
              child: Text('Dio Task'),
            ),
            Text(ref.watch(dioResponseState).isEmpty ? 'No Dio response' : ref.watch(dioResponseState)),
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}

final jsonState = StateProvider<String>((ref) => '');
final counterState = StateProvider<int>((ref) => 0);
final dioResponseState = StateProvider<String>((ref) => '');
final httpResponseState = StateProvider<String>((ref) => '');
final riverpodCounterState = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void incrementCounter() {
    state++;
  }
}
