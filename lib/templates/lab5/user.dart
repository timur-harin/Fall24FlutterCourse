// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';



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
    required Map<String, dynamic> company
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class
  final response = jsonDecode((await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'))).body) as List<dynamic>;
  final List<User> result = [];
  for (dynamic json in response) {
    Map<String, dynamic> postJson = json as Map<String, dynamic>;
    result.add(User.fromJson(postJson));
  }
  return result;
}
