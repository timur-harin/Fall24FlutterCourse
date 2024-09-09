import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String address,
    required String phone,
    required String website,
    required String company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
