import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      );
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
                String result = await fetchData();
                print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).state++,
              child: Text('Provider Task ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: ref.read(counterNotifierProvider.notifier).increment,
              child: Text('Riverpod Task ${ref.watch(counterNotifierProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://github.com/timur-harin/Fall24FlutterCourse'));
                print(response.statusCode);
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await dio.get('https://github.com/timur-harin/Fall24FlutterCourse');
                ref.read(task5Provider.notifier).state = response.data.toString();
              },
              child: Column(
                children: [
                  const Text('Dio Task'),
                  Visibility(
                      visible: ref.watch(task5Provider).isNotEmpty,
                      child: SizedBox(
                        height: 128,
                        child: Text('Response: ${ref.watch(task5Provider).trim()}'),
                      )
                  )
                ],
              ),
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

final dio = Dio();

final task5Provider = StateProvider<String>((_) => "");

final counterProvider = StateProvider<int>((_) => 0);

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((_) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => ++state;
}
