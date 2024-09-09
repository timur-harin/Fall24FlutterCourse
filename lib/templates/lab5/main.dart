import 'package:flutter/material.dart';
import 'comment_page.dart';
import 'post_page.dart';
import 'user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        final int? statusCode = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (context) => StatusPage(statusCode: statusCode ?? 404),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const UndefinedPage(),
        );
      },
      routes: {
        '/comments': (context) => CommentPage(),
        '/posts': (context) => PostPage(),
        '/users': (context) => UserPage(),
      },
    );
  }
}

class StatusPage extends StatelessWidget {
  final int statusCode;

  StatusPage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Code: $statusCode'),
      ),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undefined Route'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
              child: const Text('Comments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/posts');
              },
              child: const Text('Posts'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
              child: const Text('Users'),
            ),
          ],
        ),
      ),
    );
  }
}