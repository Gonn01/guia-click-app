// ignore_for_file: non_constant_identifier_names

import 'package:isar/isar.dart';
part 'isar_user.g.dart';

/// {@template IsarUser}
/// Isar collection for the user.
/// {@endtemplate}
@collection
class IsarUser {
  /// The id of the collection
  Id id = 1;

  /// The user
  User? user;
}

/// {@template User}
/// Model that represents the user.
/// {@endtemplate}
@embedded
class User {
  /// {@macro User}
  User({
    this.token,
    this.id,
    this.name,
    this.email,
    this.role,
  });

  /// Create a user from a json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] != null ? json['token'] as String : null,
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      role: json['role'] != null ? json['role'] as int : null,
    );
  }

  /// Convert the user to a json
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  /// The id of the user
  final int? id;

  /// The token of the user
  final String? token;

  /// The role of the user
  final int? role;

  /// The username of the user
  final String? name;

  /// The email of the user
  final String? email;

  /// Creates a copy of this object with the given properties replaced.
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
    int? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }
}
