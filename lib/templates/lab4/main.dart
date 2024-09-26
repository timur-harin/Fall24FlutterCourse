import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(Lab4());
}

class Lab4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: provider.Provider<CounterNotifier>(
          create: (context) => CounterNotifier(),
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                final providerCounter = provider.Provider.of<CounterNotifier>(
                  context,
                  listen: false,
                );
                providerCounter.increment();
                final int state = providerCounter.currentState;
                print('current counter state: $state');
              },
              child: const Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                final CounterNotifier notifier =
                ref.read(counterNotifierProvider.notifier);
                notifier.increment();
                print('current counter state: ${notifier.currentState}');
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () => _httpTask(context),
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () => _dioTask(context),
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dioTask(BuildContext context) async {
    final Dio dio = Dio();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dio Task'),
        content: FutureBuilder(
          future: dio.get('https://jsonplaceholder.typicode.com/posts/3'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _httpTask(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dio Task'),
        content: FutureBuilder(
          future: http
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

Future<String> fetchData() async {
  final Dio dio = Dio();
  final response =
  await dio.get('https://jsonplaceholder.typicode.com/posts/1');

  return response.data.toString();
}

final counterProvider = StateProvider<int>((ref) => 0);

final counterNotifierProvider =
StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state += 1;
  }

  int get currentState => state;
}