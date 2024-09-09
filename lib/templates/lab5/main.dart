import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _onGenerateRoute,
      initialRoute: '/',
    );
  }
}

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  final Uri uri = Uri.parse(settings.name ?? '');
  if (uri.pathSegments.isEmpty) {
    return MaterialPageRoute(builder: (context) => HomePage());
  }
  switch (uri.pathSegments.first) {
    case 'status':
      final status = uri.pathSegments.last; // Получаем статус из пути
      return MaterialPageRoute(
        builder: (context) => StatusPage(status: status),
      );
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) => ErrorPage(),
  );
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: Path does not exist'),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final String status;

  StatusPage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status Page")),
      body: Center(
        child: Image.network('https://http.cat/$status'), // Показ картинки статуса
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await fetchComment(); // Фетчим данные
            final statusCode = response.statusCode; // Получаем статус код
            
            Navigator.pushNamed(context, '/status/$statusCode'); // Переходим на страницу статуса
          },
          child: Text('Fetch Comment and Get Status Code'),
        ),
      ),
    );
  }
}

// Функция для выполнения HTTP запроса
Future<http.Response> fetchComment() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments/1'));
  return response;
}
