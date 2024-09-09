import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'comment.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/comments':
            return MaterialPageRoute(builder: (_) => CommentsPage());
          case '/users':
            return MaterialPageRoute(builder: (_) => UsersPage());
          default:
            final statusCode = int.tryParse(settings.name?.substring(1) ?? '404') ?? 404;
            return MaterialPageRoute(
              builder: (_) => ErrorPage(statusCode: statusCode),
            );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
              child: Text('Fetch Comments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
              child: Text('Fetch Users'),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No comments found.'));
          } else {
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.body),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final int statusCode;
  ErrorPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: Text('Error $statusCode: Page not found.'),
      ),
    );
  }
}
