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

final jsonState = StateProvider<String>((ref) => '');
final countState = StateProvider<int>((ref) => 0);
final dioResponseState = StateProvider<String>((ref) => '');
final httpResponseState = StateProvider<String>((ref) => '');

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
                String res = await fetchData();
                showMyDialog(context, "Data", res);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(countState.notifier).state++;
                showMyDialog(context, 'Counter Value', ref.watch(countState).toString());
              },
              child: Text('Provider Task: ${ref.watch(countState)}'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(rpCountState.notifier).incrementCount();
                showMyDialog(context, 'RP count: ', ref.watch(rpCountState).toString());
              },
              child: Text('Riverpod Task: ${ref.watch(rpCountState)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('Making HTTP request...');
                Map<String, dynamic> httpResponse = await fetchDataHttp();
                showMyDialog(context, httpResponse['title'], httpResponse['body']);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('Making Dio request...');
                Map<String, dynamic> res = await fetchDataDio();
                showMyDialog(context, res['title'], res['body']);
              },
              child: Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

void showMyDialog(BuildContext context, String title, String content) {
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

Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('failed to fetch');
  }
}

Future<Map<String, dynamic>> fetchDataHttp() async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('failed to load data');
    }
  } catch (e) {
    return {'error': 'Error: $e'};
  }
}

Future<Map<String, dynamic>> fetchDataDio() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('failed to load data');
    }
  } catch (e) {
    return {'error': 'Error: $e'};
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

final rpCountState =
    StateNotifierProvider<CountNotifier, int>((ref) => CountNotifier());

class CountNotifier extends StateNotifier<int> {
  CountNotifier() : super(0);
  void incrementCount() {
    state++;
  }
}
