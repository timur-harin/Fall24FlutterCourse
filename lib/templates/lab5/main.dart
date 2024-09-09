import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'post.dart';
import 'comment.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/status/404',
      builder: (context, state) => StatusScreen(statusCode: '404')
    ),
    GoRoute(
      path: '/posts',
      builder: (context, state) => PostsScreen(),
    ),
    GoRoute(
      path: '/comments',
      builder: (context, state) => CommentsScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => UsersScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
            _buildNavigationButton(context, 'StatusCat', '/status'),
            _buildNavigationButton(context, 'posts', '/posts'),
            _buildNavigationButton(context, 'comments', '/comments'),
            _buildNavigationButton(context, 'users', '/users'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String text, String route) {
    return ElevatedButton(
        onPressed: () {
          context.go(route);
        },
        child: Text(text));
  }
}

class StatusScreen extends StatelessWidget {
  final String statusCode;

  StatusScreen({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://http.cat/$statusCode';

    return Scaffold(
      appBar: AppBar(title: Text('Status Code: $statusCode')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Status Code: $statusCode'),
            SizedBox(height: 20),
            Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Posts Found'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CommentsScreen extends StatelessWidget {
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
            return Center(child: Text('No Comments Found'));
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

class UsersScreen extends StatelessWidget {
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
            return Center(child: Text('No Users Found'));
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
