import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    final counter = ref.watch(counterProvider);
    final riverpodCounter = ref.watch(riverpodCounterProvider);
    final dioResponse = ref.watch(dioProvider);

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
                print("Async/Await Task: $result");
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task - Count: $counter'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(riverpodCounterProvider.notifier).increment();
              },
              child: Text('Riverpod Task - Count: $riverpodCounter'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                print('HTTP Response: ${response.body}');
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(dioProvider.notifier).fetchData();
              },
              child: const Text('Dio Task'),
            ),
            dioResponse.when(
              data: (data) => Text('Dio Response: $data'),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  return response.body;
}

final counterProvider = StateProvider<int>((ref) => 0);

final riverpodCounterProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}

// StateNotifier for handling Dio responses
class DioNotifier extends StateNotifier<AsyncValue<String>> {
  DioNotifier() : super(const AsyncValue.data("Click button Dio Task"));

  final Dio _dio = Dio();

  Future<void> fetchData() async {
    try {
      state = const AsyncValue.data("Click button Dio Task");
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts/1');
      state = AsyncValue.data(response.data.toString());
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}

final dioProvider = StateNotifierProvider<DioNotifier, AsyncValue<String>>((ref) {
  return DioNotifier();
});
