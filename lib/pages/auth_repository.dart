import 'package:guia_click/models/user/isar_user.dart';
import 'package:guia_click/utilities/repository.dart';

abstract class AuthRepository {
  static Future<ResponseLD<User>> login(String email, String password) async {
    final response = await Repository.post<User>(
      url: 'http://10.0.2.2:3000/.netlify/functions/server/login',
      fromJson: (json) => User.fromJson(json['body'] as Map<String, dynamic>),
      additionalKeys: {
        'email': email,
        'password': password,
      },
    );

    return response;
  }

  static Future<ResponseLD<bool>> register(
    String name,
    String email,
    String password,
  ) async {
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
