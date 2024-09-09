import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
      home: HomePage(),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name ?? '');
    if (uri.pathSegments.first == 'cat' && uri.pathSegments.length == 2) {
      final status_code = uri.pathSegments[1];
      return MaterialPageRoute(builder: (context) => StatusPage(status_code: status_code));
    }
    return MaterialPageRoute(builder: (context) => UndefinedPage());
  }
}
class UndefinedPage extends StatelessWidget {
  final catUrl = 'https://http.cat/404';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page is not defined', style: TextStyle(color: Colors.white, fontSize: 30),),
        foregroundColor: Colors.red,
      ),
      body: Center(
        child: Image.network(catUrl),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: Colors.white, fontSize: 30),),
        foregroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/', arguments: 404);
              },
              child: Text('Status Code 404'),
            ),
          ],
        )
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  String status_code;
  StatusPage({required this.status_code});
  @override
  Widget build(BuildContext context) {
    final catUrl = 'https://http.cat/$status_code';
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code: $status_code', style: TextStyle(color: Colors.white, fontSize: 30),),
        foregroundColor: Colors.red,
      ),
      body: Center(
        child: Image.network(catUrl),
      ),
    );
  }
}
// TODO add putting argument in route navigation as parameter for generated page