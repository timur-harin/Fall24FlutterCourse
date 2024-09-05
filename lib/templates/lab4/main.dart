import 'dart:io';
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
    final counter = ref.watch(counterProvider);
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
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                print(result);
                child: Text("$result");
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter

                ref.read(counterProvider.notifier).state++;
                print(ref.read(counterProvider.notifier).state);
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter

                ref.read(counterNotifierProvider.notifier).increment();
                print(ref.read(counterNotifierProvider.notifier).state);
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                try {
                  final HttpResponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                  if (HttpResponse.statusCode == 200) {
                    print(HttpResponse.body);
                  } else {
                    throw Exception('Failed to load data');
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                try {
                  var dio = Dio();
                  final DioResponse = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                  if (DioResponse.statusCode == 200) {
                    print(DioResponse.data);
                  } else {
                    throw Exception('Failed to load data');
                  }
                } catch (e) {
                  print('Error: $e');
                }
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
  // Get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  try {
    final resp = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Error();
  }

}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
final counterNotifierProvider = StateNotifierProvider<counterNotifier, int>((ref)=>counterNotifier());

// TODO create class for state notifier
class counterNotifier extends StateNotifier<int> {
  counterNotifier() : super(0);

  void increment(){state++;}
  int getState(){return state;}
}
