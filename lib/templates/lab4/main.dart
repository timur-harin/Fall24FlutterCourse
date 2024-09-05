import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider, Provider;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()), // Provider
      ],
      child: ProviderScope(child: MyApp()), // Riverpod
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final asyncResult = ref.watch(asyncResultProvider);
    final httpResult = ref.watch(httpResultProvider);
    final dioResult = ref.watch(dioResultProvider);
    final counter = Provider.of<CounterProvider>(context).counter;
    final counterNotifier = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the result of Async/Await Task
            Text('Async Result: $asyncResult'),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                ref.read(asyncResultProvider.notifier).state = result; // Update state
              },
              child: Text('Async/Await Task'),
            ),
            // Display the result of Provider Task (simple counter)
            Text('Provider Counter: $counter'),
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterProvider>(context, listen: false).increment();
              },
              child: Text('Provider Task'),
            ),
            // Display the result of Riverpod Task (advanced counter)
            Text('Riverpod Counter: $counterNotifier'),
            ElevatedButton(
              onPressed: () {
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),
            // Display the result of HTTP Task
            Text('HTTP Result: $httpResult'),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  ref.read(httpResultProvider.notifier).state = response.body; // Update state
                } else {
                  ref.read(httpResultProvider.notifier).state = 'Failed to fetch data';
                }
              },
              child: Text('HTTP Task'),
            ),
            // Display the result of Dio Task
            Text('Dio Result: $dioResult'),
            ElevatedButton(
              onPressed: () async {
                try {
                  Dio dio = Dio();
                  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                  ref.read(dioResultProvider.notifier).state = response.data.toString(); // Update state
                } catch (e) {
                  ref.read(dioResultProvider.notifier).state = 'Dio Error: $e';
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

// Fetch data asynchronously using async/await
Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body; // returning the body of the response as a string
  } else {
    throw Exception('Failed to load data');
  }
}

// Provider state management (simple counter)
class CounterProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

// Riverpod state management (advanced counter using StateNotifier)
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

final asyncResultProvider = StateProvider<String>((ref) => 'No data yet');

final httpResultProvider = StateProvider<String>((ref) => 'No data yet');

final dioResultProvider = StateProvider<String>((ref) => 'No data yet');
