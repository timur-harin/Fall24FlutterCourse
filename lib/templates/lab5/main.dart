import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'comment.dart';
import 'user.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Status Code Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case '/catStatus':
            final int statusCode = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => CatStatusPage(statusCode: statusCode),
            );
          default:
            return MaterialPageRoute(builder: (context) => UndefinedPage());
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  Future<void> navigateBasedOnFetch(
      BuildContext context, Future<http.Response> Function() fetchMethod) async {
    try {
      // Trigger the fetch method
      final response = await fetchMethod();
      final statusCode = response.statusCode;

      // Navigate to the cat status page based on the response status code
      Navigator.pushNamed(context, '/catStatus', arguments: statusCode);
    } catch (error) {
      // If any error occurs, navigate to the 500 cat page
      Navigator.pushNamed(context, '/catStatus', arguments: 500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                navigateBasedOnFetch(context, fetchComments);
              },
              child: Text('Fetch Comments'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateBasedOnFetch(context, fetchUsers);
              },
              child: Text('Fetch Users'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateBasedOnFetch(context, fetchPosts());
              },
              child: Text('Fetch Posts'),
            ),
          ],
        ),
      ),
    );
  }
}

class CatStatusPage extends StatelessWidget {
  final int statusCode;

  CatStatusPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = 'https://http.cat/$statusCode';

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status $statusCode'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Undefined Page',
              style: TextStyle(fontSize: 24),
            ),
            Image.network('https://http.cat/404'),
          ],
        ),
      ),
    );
  }
}
