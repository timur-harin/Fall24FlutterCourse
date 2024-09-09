import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/post') {
          final Post post = settings.arguments as Post;
          return MaterialPageRoute(
            builder: (context) => PostPage(post: post),
          );
        }
        return MaterialPageRoute(
          builder: (context) => UndefinedPage(),
        );
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                List<Post> posts = await fetchPosts();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostListPage(posts: posts),
                  ),
                );
              },
              child: Text('Fetch Posts'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/undefined');
              },
              child: Text('Show Undefined Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostListPage extends StatelessWidget {
  final List<Post> posts;

  PostListPage({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            onTap: () {
              Navigator.pushNamed(context, '/post', arguments: posts[index]);
            },
          );
        },
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  final Post post;

  PostPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([fetchComments(), fetchUsers()]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(post.title),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(post.title),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          List<Comment> comments = snapshot.data![0];
          List<User> users = snapshot.data![1];
          User? author = users.firstWhere((user) => user.id == post.userId, orElse: () => User(id: 0, name: 'Unknown', username: 'unknown', email: 'unknown'));

          return Scaffold(
            appBar: AppBar(
              title: Text(post.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Author: ${author.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(post.body),
                  SizedBox(height: 20),
                  Text('Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        if (comments[index].postId == post.id) {
                          User? commentUser = users.firstWhere((user) => user.id == comments[index].postId, orElse: () => User(id: 0, name: 'Unknown', username: 'unknown', email: 'unknown'));
                          return ListTile(
                            title: Text(comments[index].name),
                            subtitle: Text('By: ${commentUser.name}\n${comments[index].body}'),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Page'),
      ),
      body: Center(
        child: Image.network(
        'https://http.cat/404',
        errorBuilder: (context, error, stackTrace) {
          return Text('Error loading image');
          },
        ),
      ),
    );
  }
}
