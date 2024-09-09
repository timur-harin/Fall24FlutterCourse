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
      onGenerateRoute: (settings) {
        if (settings.name == '/undefined') {
          return MaterialPageRoute(builder: (context) => UndefinedPage());
        } else if (settings.name == '/post') {
          final Post post = settings.arguments as Post;
          return MaterialPageRoute(
            builder: (context) => PostDetailView(post: post),
          );
        } else if (settings.name == '/success') {
          return MaterialPageRoute(builder: (context) => SuccessPage());
        } else {
          return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
      initialRoute: '/',
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
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/undefined');
              },
              child: Text('Go to Undefined Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/success');
              },
              child: Text("Go to Success Page")
            ),
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
          ] 
        )
      ),
    );
  }
}

class PostListPage extends StatelessWidget {
  final List<Post> posts;

  const PostListPage({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostDetailView(post: post),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(post.title, style: TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}

class PostDetailView extends StatefulWidget {
  final Post post;

  const PostDetailView({required this.post});

  @override
  _PostDetailViewState createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = Future.wait([fetchComments(), fetchUsers()]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        } else if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error);
        } else {
          final comments = snapshot.data![0] as List<Comment>;
          final users = snapshot.data![1] as List<User>;
          return _buildContentScreen(comments, users);
        }
      },
    );
  }

  Scaffold _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Scaffold _buildErrorScreen(Object? error) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Center(child: Text('Error: $error')),
    );
  }

  Scaffold _buildContentScreen(List<Comment> comments, List<User> users) {
    final author = users.firstWhere(
      (user) => user.id == widget.post.userId,
      orElse: () => User(id: 0, name: 'Unknown', username: 'unknown', email: 'unknown'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${author.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(widget.post.body),
            const SizedBox(height: 20),
            const Text('Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  if (comment.postId == widget.post.id) {
                    final commentUser = users.firstWhere(
                      (user) => user.id == comment.postId,
                      orElse: () => User(id: 0, name: 'Unknown', username: 'unknown', email: 'unknown'),
                    );
                    return ListTile(
                      title: Text(comment.name),
                      subtitle: Text('By: ${commentUser.name}\n${comment.body}'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Undefined Page')),
      body: Center(
        child: Image.network(
          'https://http.cat/404',
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 50),
                SizedBox(height: 10),
                Text(
                  'Failed to load image',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success Page')),
      body: Center(
        child: Image.network(
          'https://http.cat/200',
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 50),
                SizedBox(height: 10),
                Text(
                  'Failed to load image',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}