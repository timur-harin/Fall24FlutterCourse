// Use these dependencies for your classes
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


void main() => runApp(const Lab5App());

class Lab5App extends StatelessWidget {
  const Lab5App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  final Uri uri = Uri.parse(settings.name ?? '/');
  switch(uri.pathSegments.first) {
    case '/':
      return MaterialPageRoute(builder: (context) => const HomePage());
    case 'cat':
      if(uri.pathSegments.length == 2) {
        final String id = uri.pathSegments[1];
        return MaterialPageRoute(builder: (context) => CatPage(id: id));
      } else {
        return MaterialPageRoute(builder: (context) => const ErrorPage());
      }
    default:
      return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Response res = await post(Uri.https('google.com'));
              res.statusCode;
              Navigator.pushNamed(context, '/cat/${res.statusCode}');
            },
            child: const Text('Get response')
          )
        ]
      )
    );
  }
}

class CatPage extends StatelessWidget {
  final String id;
  const CatPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cat'),
      ),
      body: Column(
        children: [
          Image.network('https://http.cat/$id', fit: BoxFit.contain)
        ]
      )
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('An error in routing')
    );
  }
}



// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

