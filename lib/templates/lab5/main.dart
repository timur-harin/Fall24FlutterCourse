// Use these dependencies for your classes
import 'dart:convert';
import 'package:build_runner/build_runner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      title: 'Cat status',
      home: HomePage(),
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
          children: [
            ElevatedButton(
              onPressed: () async{
                List<Post> posts = await fetchPosts();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage(post: posts[0], statusCode: 200)),
                );
              },
              child: Text('Posts'),
            ),
            ElevatedButton(
              onPressed: () async{
                List<Comment> comments = await fetchComments();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommentPage(comment: comments[0], statusCode: 200)),
                );
              },
              child: Text('Comments'),
            ),
            ElevatedButton(
              onPressed: () async{
                List<User> users = await fetchUsers();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage(user: users[0], statusCode: 200)),
                );
              },
              child: Text('Users')),
          ],
        ),
      ),
      );
  }
}

class PostPage extends StatelessWidget {
  final Post post;
  final int statusCode;
  PostPage({required this.post, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: Center(
        child: Column(
          children: [
            Text(post.title),
            Text(post.body),
            Image.network('https://http.cat/$statusCode')
          ],
        ),
      ),
    );
  }
}

class CommentPage extends StatelessWidget {
  final Comment comment;
  final int statusCode;
  CommentPage({required this.comment, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Center(
        child: Column(
          children: [
            Text(comment.body),
            Image.network('https://http.cat/$statusCode')
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final User user;
  final int statusCode;
  UserPage({required this.user, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Center(
        child: Column(
          children: [
            Text(user.name),
            Text(user.email),
            Image.network('https://http.cat/$statusCode')
          ],
        ),
      ),
    );
  }
}

// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

