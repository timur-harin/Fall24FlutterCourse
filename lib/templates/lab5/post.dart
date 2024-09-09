// TODO add dependencies

import 'package:dio/dio.dart';

// void main() async {
//   print(await fetchPosts());
// }

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson(Post post) {
    return {
      'userId': post.userId,
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
  }

  @override
  String toString() =>
      'Post(\n\tuserId: $userId\n\tid: $id\n\ttitle: $title\n\tbody: $body\n)';
}

Future<List<Post>> fetchPosts() async {
  final Response response =
      await getData('https://jsonplaceholder.typicode.com/posts');
  final List<Post> posts = [];
  for (dynamic postJson in response.data as List<dynamic>) {
    posts.add(Post.fromJson(postJson as Map<String, dynamic>));
  }
  return posts;
}

Future<Response> getData(String path) async {
  final Dio dio = Dio();
  return await dio.get(path);
}
