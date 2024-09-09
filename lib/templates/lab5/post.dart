import 'package:dio/dio.dart';
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
}

//I have changed return type of function to get responce
// (actual posts are still available and working fine)
Future<Response> fetchPosts() async {
  final Response response =
  await getData('https://jsonplaceholder.typicode.com/posts');
  final List<Post> posts = [];
  for (dynamic postJson in response.data as List<dynamic>) {
    posts.add(Post.fromJson(postJson as Map<String, dynamic>));
  }
  return response;
}

Future<Response> getData(String path) async {
  final Dio dio = Dio();
  return await dio.get(path);
}