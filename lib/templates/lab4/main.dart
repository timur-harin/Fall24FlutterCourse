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
                Map<String, dynamic> fetchedData = await fetchData();

                if (fetchedData.containsKey('error')) {
                  _showDialog(context, 'Error', fetchedData['error']);
                } else {
                  _showDialog(
                      context, fetchedData['title'], fetchedData['body']);
                }
              },
              child: Text('Async/Await Task'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(counterState.notifier).state++;
                _showDialog(context, 'Counter Value',
                    ref.watch(counterState).toString());
              },
              child: Text('Provider Task = ${ref.watch(counterState)}'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(riverpodCounterState.notifier).incrementCounter();
                _showDialog(context, 'Riverpod Counter Value',
                    ref.watch(riverpodCounterState).toString());
              },
              child: Text('Riverpod Task = ${ref.watch(riverpodCounterState)}'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('Making HTTP request...');
                Map<String, dynamic> httpResponse = await fetchDataAsMap();
                if (httpResponse.containsKey('error')) {
                  _showDialog(context, 'Error', httpResponse['error']);
                } else {
                  _showDialog(
                      context, httpResponse['title'], httpResponse['body']);
                }
              },
              child: Text('HTTP Task'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('Making Dio request...');
                Map<String, dynamic> dioResponse = await fetchDataDio();

                if (dioResponse.containsKey('error')) {
                  _showDialog(context, 'Error', dioResponse['error']);
                } else {
                  _showDialog(
                      context, dioResponse['title'], dioResponse['body']);
                }
              },
              child: Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        // Decode the JSON data
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> fetchDataAsMap() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        // Decode the JSON data
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> fetchDataDio() async {
    try {
      final dio = Dio();
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts/1');

      if (response.statusCode == 200) {
        // Decode the JSON data
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}

final jsonState = StateProvider<String>((ref) => '');
final counterState = StateProvider<int>((ref) => 0);
final dioResponseState = StateProvider<String>((ref) => '');
final httpResponseState = StateProvider<String>((ref) => '');
final riverpodCounterState =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void incrementCounter() {
    state++;
  }
}
