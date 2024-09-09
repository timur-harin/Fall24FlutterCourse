import 'package:dio/dio.dart';
import 'package:fall_24_flutter_course/templates/lab5/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Map<String, dynamic> address,
    required String phone,
    required String website,
    required Map<String, dynamic> company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

//I have changed return type of function to get response
// (actual users are still available and working fine)
Future<Response> fetchUsers() async {
  final Response response =
      await getData('https://jsonplaceholder.typicode.com/users');

  final List<User> users = [];

  for (dynamic userJson in response.data as List<dynamic>) {
    users.add(User.fromJson(userJson as Map<String, dynamic>));
  }

  return response;
}
