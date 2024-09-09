import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomePage());
        } else if (settings.name == '/statusDetails') {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(builder: (context) => StatusDetailsPage(statusCode: statusCode));
        } else {
          return MaterialPageRoute(builder: (context) => UndefinedPage(statusCode: 404));
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/statusDetails', arguments: 200);
              },
              child: Text('Go to Status Code 200'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/statusDetails', arguments: 404);
              },
              child: Text('Go to Status Code 404'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusDetailsPage extends StatelessWidget {
  final int statusCode;
  StatusDetailsPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Status Code Details')),
      body: Center(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: 'https://http.cat/$statusCode',
          imageErrorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 100),
                SizedBox(height: 10),
                Text('Failed to load image for status code $statusCode', style: TextStyle(fontSize: 18)),
              ],
            );
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  final int statusCode;
  UndefinedPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: 'https://http.cat/$statusCode',
          imageErrorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 100),
                SizedBox(height: 10),
                Text('Failed to load image for status code $statusCode', style: TextStyle(fontSize: 18)),
              ],
            );
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
