import 'package:guia_click/utilities/repository.dart';

abstract class AuthRepository {
  static Future<ResponseLD<User>> login(String email, String password) async {
    final response = await Repository.post<User>(
        url: 'http://10.0.2.2:3000/.netlify/functions/server/login',
        fromJson: (json) => User.fromJson(json['body'] as Map<String, dynamic>),
        additionalKeys: {
          'email': email,
          'password': password,
        });

    return response;
  }

  static Future<ResponseLD<bool>> register(
      String name, String email, String password) async {
    final response = await Repository.post<bool>(
      url: 'http://10.0.2.2:3000/.netlify/functions/server/users',
      fromJson: (json) => json['body'] != null,
      additionalKeys: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response;
  }
}

class User {
  User({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as int,
    );
  }
  @override
  String toString() {
    return 'User(token: $token, id: $id, name: $name, email: $email, role: $role)';
  }

  final String token;
  final int id;
  final String name;
  final String email;
  final int role;
}
