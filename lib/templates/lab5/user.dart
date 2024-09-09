import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String username,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
