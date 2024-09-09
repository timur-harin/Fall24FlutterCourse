import 'package:flutter/material.dart';
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
      title: 'HTTP Data Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
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
              onPressed: () async {
                List<Post> posts = await fetchPosts();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsPage(post: posts[0], statusCode: 200),
                  ),
                );
              },
              child: Text('See Post Details'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Comment> comments = await fetchComments();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentDetailsPage(comment: comments[0], statusCode: 200),
                  ),
                );
              },
              child: Text('See Comment Details'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<User> users = await fetchUsers();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailsPage(user: users[0], statusCode: 200),
                  ),
                );
              },
              child: Text('See User Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailsPage extends StatelessWidget {
  final Post post;
  final int statusCode;

  PostDetailsPage({required this.post, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.body),
            SizedBox(height: 20),
            Text('Status Code: $statusCode'),
            Image.network('https://http.cat/$statusCode'),
          ],
        ),
      ),
    );
  }
}

class CommentDetailsPage extends StatelessWidget {
  final Comment comment;
  final int statusCode;

  CommentDetailsPage({required this.comment, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comment by ${comment.email}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.body),
            SizedBox(height: 20),
            Text('Status Code: $statusCode'),
            Image.network('https://http.cat/$statusCode'),
          ],
        ),
      ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final User user;
  final int statusCode;

  UserDetailsPage({required this.user, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User: ${user.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}'),
            Text('ID: ${user.id}'),
            Text('Email: ${user.email}'),
            SizedBox(height: 20),
            Text('Status Code: $statusCode'),
            Image.network('https://http.cat/$statusCode'),
          ],
        ),
      ),
    );
  }
}
