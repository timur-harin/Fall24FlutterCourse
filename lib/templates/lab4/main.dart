import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider, Provider;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final currentResponseProvider = StateProvider<String>((ref) => '');

void main() {
  runApp(
    // Оборачиваем все приложение в ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => Counter(), // Предоставляем экземпляр Counter
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
    final currentResponse = ref.watch(currentResponseProvider);
    final riverpodCounter = ref.watch(counterProvider);
    final providerCounter = Provider.of<Counter>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current HTTP response: ${ref.read(currentResponseProvider.notifier).state}'),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                ref.read(currentResponseProvider.notifier).state = result;
              },
              child: Text('Async/Await Task'),
            ),
            Text('Provider counter: ${providerCounter.count}'),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                providerCounter.increment();
              },
              child: Text('Provider Task'),
            ),
            Text('Riverpod counter: ${riverpodCounter}'),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2'));
                ref.read(currentResponseProvider.notifier).state = res.body;
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                String result = await fetchWithDio();
                ref.read(currentResponseProvider.notifier).state = result;
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
  // TODO get json from url and show as text
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchWithDio() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/3');
    return response.data.toString();
  } catch (e) {
    return 'Error: $e';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class Counter extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners(); // Уведомляем слушателей об изменении состояния
  }
}


// TODO create a state notifier
// final 

// TODO create class for state notifier