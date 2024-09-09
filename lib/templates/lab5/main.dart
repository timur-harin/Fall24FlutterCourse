// Use these dependencies for your classes
import 'dart:convert';
import 'package:flutter/material.dart';

import 'user.dart';
import 'post.dart';
import 'comment.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/status') {
          final args = settings.arguments as StatusPageArguments;
          return MaterialPageRoute(
            builder: (context) => StatusPage(statusCode: args.statusCode),
          );
        }
        // Fallback for undefined routes
        return MaterialPageRoute(
          builder: (context) => UndefinedPage(),
        );
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => UndefinedPage(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Codes App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/status',
                  arguments: StatusPageArguments(404),
                );
              },
              child: Text('Show Cat for 404'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/status',
                  arguments: StatusPageArguments(500),
                );
              },
              child: Text('Show Cat for 500'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final int statusCode;

  const StatusPage({Key? key, required this.statusCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code: $statusCode'),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: http.get(Uri.parse('https://http.cat/$statusCode')),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data?.statusCode == 200) {
              return Image.network('https://http.cat/$statusCode');
            } else {
              return Text('Cat not found for status code $statusCode');
            }
          },
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404 - Undefined Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Oops! Page not found!'),
            SizedBox(height: 20),
            Image.network('https://http.cat/404'),
          ],
        ),
      ),
    );
  }
}

class StatusPageArguments {
  final int statusCode;

  StatusPageArguments(this.statusCode);
}

// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

