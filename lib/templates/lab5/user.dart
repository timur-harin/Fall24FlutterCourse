// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';



@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
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
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class

  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));

  return (json.decode(response.body) as List).map((data) => User.fromJson(data)).toList();
}
