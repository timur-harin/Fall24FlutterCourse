import 'package:dio/dio.dart';
import 'package:fall_24_flutter_course/templates/lab5/company.dart';
import 'package:fall_24_flutter_course/templates/lab5/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'address.dart';

part 'user.freezed.dart';
part 'user.g.dart';

// void main() async {
//   print(await fetchUsers());
// }

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    @JsonKey(fromJson: User.addressFromJson)
    required Address address,
    required String phone,
    required String website,
    @JsonKey(fromJson: User.companyFromJson)
    required Company company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static Address addressFromJson(Map<String, dynamic> json) => Address.fromJson(json);

  static Company companyFromJson(Map<String, dynamic> json) => Company.fromJson(json);
}

Future<List<User>> fetchUsers() async {
  final Response response = await getData('https://jsonplaceholder.typicode.com/users');

  final List<User> users = [];

  for (dynamic userJson in response.data as List<dynamic>) {
    users.add(User.fromJson(userJson as Map<String, dynamic>));
  }

  return users;
}
