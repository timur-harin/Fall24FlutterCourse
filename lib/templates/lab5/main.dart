// Use these dependencies for your classes
import 'dart:convert';
import 'package:fall_24_flutter_course/templates/lab5/comment.dart';
import 'package:fall_24_flutter_course/templates/lab5/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


void main() {
  runApp(MyApp());
}

// TODO add needed classes for Flutter APP
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _generateRoute,
      initialRoute: '/',
    );
  }

  // TODO add generated route flutter app with undifined page with cat status code using api
  Route<dynamic>? _generateRoute(RouteSettings settings){
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/postDetails':
        final postId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => PostDetailsPage(postId: postId));
      default:
        final uri = Uri.parse('https://http.cat/${settings.name?.substring(1)}');
        return MaterialPageRoute(
          builder: (_) => UndefinedPage(uri: uri),
        );
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/postDetails',
              arguments: 1,
            );
          },
          child: Text('Go to Post Details'),
        ),
      ),
    );
  }
}

class PostDetailsPage extends StatelessWidget {
  final int postId;

  PostDetailsPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: FutureBuilder(
        future: Future.wait([fetchPosts(), fetchComments()]), 
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No post found.'));
          } else {
            final posts = snapshot.data![0] as List<Post>;
            final comments = snapshot.data![1] as List<Comment>;

            final post = posts.firstWhere((post) => post.id == postId,
              orElse: () => Post(userId: 0, id: 0, title: 'Not Found', body: 'No content')
            );

            final postComment = comments.where((comment) => comment.postId == post.id).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(post.title, style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                    const SizedBox(height: 10),
                    Text(post.body),
                    const SizedBox(height: 15),
                    const Text ('Comments:', style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                    ...postComment.map((comment){
                      return ListTile(
                        title: Text(comment.name),
                        subtitle: Text(comment.body),
                      );
                    }),
                  ],
                )
              ),
            );
          }
        }
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  final Uri uri;

  UndefinedPage({required this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Undefined Page')),
      body: Center(
        child: Image.network(uri.toString()),
      ),
    );
  }
}

