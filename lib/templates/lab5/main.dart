import 'package:flutter/material.dart';
import 'user.dart';
import 'post.dart';
import 'comment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: _onGenerateRoute,
      home: const HomeScreen(),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    if (settings.name == UserDetailPage.routeName) {
      final User user = settings.arguments as User;
      return MaterialPageRoute(
        builder: (context) => UserDetailPage(user: user),
      );
    } else if (settings.name == PostsPage.routeName) {
      final int userId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => PostsPage(userId: userId),
      );
    }

    return MaterialPageRoute(
      builder: (context) => UndefinedRoutePage(statusCode: settings.arguments as int?),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<User>>? _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          final users = snapshot.data!.toList(); 

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    UserDetailPage.routeName,
                    arguments: user,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  static const routeName = '/user-detail';
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            Text('Phone: ${user.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PostsPage.routeName, arguments: user.id);
              },
              child: const Text('View Posts'),
            )
          ],
        ),
      ),
    );
  }
}

class PostsPage extends StatelessWidget {
  static const routeName = '/posts';

  final int userId;

  const PostsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Posts')),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts yet!'));
          }

          final posts = snapshot.data!.where((post) => post.userId == userId).toList();

          return FutureBuilder<List<Comment>>(
            future: Comment.fetchComments(),
            builder: (context, commentSnapshot) {
              if (commentSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (commentSnapshot.hasError) {
                return Center(child: Text('Error: ${commentSnapshot.error}'));
              } else if (!commentSnapshot.hasData || commentSnapshot.data!.isEmpty) {
                return const Center(child: Text('No comments yet!'));
              }

              final comments = commentSnapshot.data!;

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final postComments = comments.where((comment) => comment.postId == post.id).toList();

                  return Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(post.body),
                          const SizedBox(height: 10),
                          
                          const Divider(),
                          const Text('Comments:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          ...postComments.map((comment) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Card(
                                  color: Colors.grey[300],
                                  margin: const EdgeInsets.only(bottom: 5),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(comment.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text(comment.body),
                                        const SizedBox(height: 5),
                                        Text('Email: ${comment.email}', style: const TextStyle(fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UndefinedRoutePage extends StatelessWidget {
  final int? statusCode;

  const UndefinedRoutePage({super.key, this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Something went wrong.'),
            if (statusCode != null)
              Image.network('https://http.cat/$statusCode'),
          ],
        ),
      ),
    );
  }
}