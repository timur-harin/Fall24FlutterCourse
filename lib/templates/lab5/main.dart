import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'comment.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'post') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => PostPage(id: id));
        } else if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'user') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => UserPage(id: id));
        } else if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'comment') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => CommentPage(id: id));
        } else {
          return MaterialPageRoute(builder: (context) => const ErrorPage());
        }
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder(
        future: Future.wait([fetchPosts(), fetchUsers(), fetchComments()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final posts = snapshot.data![0] as List<Post>;
            final users = snapshot.data![1] as List<User>;
            final comments = snapshot.data![2] as List<Comment>;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Posts:', style: TextStyle(fontSize: 24)),
                  ...posts.take(10).map((post) {
                    return ListTile(
                      title: Text(post.title),
                      onTap: () {
                        Navigator.pushNamed(context, '/post/${post.id}');
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  const Text('Users:', style: TextStyle(fontSize: 24)),
                  ...users.take(10).map((user) {
                    return ListTile(
                      title: Text(user.name),
                      onTap: () {
                        Navigator.pushNamed(context, '/user/${user.id}');
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  const Text('Comments:', style: TextStyle(fontSize: 24)),
                  ...comments.take(10).map((comment) {
                    return ListTile(
                      title: Text(comment.name),
                      onTap: () {
                        Navigator.pushNamed(context, '/comment/${comment.id}');
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  final String id;

  const PostPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post $id')),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([fetchPosts(), fetchComments()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Post or comments not found'));
          } else {
            final posts = snapshot.data![0] as List<Post>;
            final comments = snapshot.data![1] as List<Comment>;

            final post = posts.firstWhere((post) => post.id == int.parse(id),
                orElse: () => Post(
                    userId: 0, id: 0, title: 'Not Found', body: 'No content'));

            final postComments =
                comments.where((comment) => comment.postId == post.id).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(post.body),
                    const SizedBox(height: 16),
                    const Text('Comments:', style: TextStyle(fontSize: 24)),
                    ...postComments.map((comment) {
                      return ListTile(
                        title: Text(comment.name),
                        subtitle: Text(comment.body),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String id;

  const UserPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User $id')),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([fetchUsers(), fetchPosts()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('User not found'));
          } else {
            final users = snapshot.data![0] as List<User>;
            final posts = snapshot.data![1] as List<Post>;

            final user = users.firstWhere((user) => user.id == int.parse(id),
                orElse: () => User(
                    id: 0,
                    name: 'Not Found',
                    username: 'N/A',
                    email: 'N/A',
                    address: {},
                    phone: 'N/A',
                    website: 'N/A',
                    company: {}));

            final userPosts =
                posts.where((post) => post.userId == user.id).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Username: ${user.username}'),
                    const SizedBox(height: 8),
                    Text('Email: ${user.email}'),
                    const SizedBox(height: 16),
                    const Text('Posts:', style: TextStyle(fontSize: 24)),
                    ...userPosts.map((post) {
                      return ListTile(
                        title: Text(post.title),
                        onTap: () {
                          Navigator.pushNamed(context, '/post/${post.id}');
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CommentPage extends StatelessWidget {
  final String id;

  const CommentPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comment $id')),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Comment not found'));
          } else {
            final comment = snapshot.data!.firstWhere(
                (comment) => comment.id == int.parse(id),
                orElse: () => Comment(
                    postId: 0,
                    id: 0,
                    name: 'Not Found',
                    email: 'N/A',
                    body: 'No content'));

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Email: ${comment.email}'),
                  const SizedBox(height: 8),
                  Text(comment.body),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}
