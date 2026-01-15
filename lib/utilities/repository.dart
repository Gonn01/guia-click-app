import 'dart:convert';

import 'package:guia_click/services/local_storage.dart';
import 'package:http/http.dart' as http;

/// {@template Repository}
/// Base class for repositories
/// {@endtemplate}
abstract class Repository {
  /// Manejo de excepciones personalizadas
  static Never handleException(Object e, StackTrace st) {
    if (e is TypeError) {
      throw CustomException(
        title: 'Error de tipo',
        message: 'Error de tipo ${e.runtimeType}: $e',
      );
    }
    if (e.runtimeType != CustomException) {
      throw CustomException(
        title: 'Error desconocido',
        message: e.toString(),
      );
    }

    final error = e as CustomException;

    return switch (e.runtimeType) {
      _ => throw CustomException(
          title: error.title,
          message: error.message,
          stack: st,
        ),
    };
  }

  /// Manejo de la respuesta HTTP con tipado genérico
  static ResponseLD<T> handleResponse<T>(
    http.Response response,
    ResponseLD<T> fromJson,
    Map<String, dynamic> jsonData,
  ) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CustomException(
        title: 'Error en la respuesta',
        message: 'Error HTTP ${response.statusCode}: ${jsonData['message']}',
      );
    }

    return fromJson;
  }

  /// Método para realizar una petición POST a la API
  static Future<ResponseLD<T>> post<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? additionalKeys,
  }) async {
    final data = <String, dynamic>{};

    if (additionalKeys != null) {
      data.addAll(additionalKeys);
    }

    try {
      final user = await LocalStorage.getUser();
      final token = user?.token;
      final urlUri = Uri.parse(url);
      final response = await http.post(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        final result = Repository.handleResponse(
          response,
          ResponseLD.fromJson(
            jsonData,
            (json) => fromJson(jsonData),
          ),
          jsonData,
        );

        return result;
      } else {
        throw Exception(response.body);
      }
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }

  static Future<ResponseLD<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? additionalKeys,
  }) async {
    final data = <String, dynamic>{};

    if (additionalKeys != null) {
      data.addAll(additionalKeys);
    }

    try {
      final user = await LocalStorage.getUser();
      final token = user?.token;
      final urlUri = Uri.parse(url);
      final response = await http.get(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        final result = Repository.handleResponse(
          response,
          ResponseLD.fromJson(
            jsonData,
            (json) => fromJson(jsonData),
          ),
          jsonData,
        );

        return result;
      } else {
        throw Exception(response.body);
      }
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }

  static Future<ResponseLD<T>> delete<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? additionalKeys,
  }) async {
    final data = <String, dynamic>{};

    if (additionalKeys != null) {
      data.addAll(additionalKeys);
    }

    try {
      final user = await LocalStorage.getUser();
      final token = user?.token;
      final urlUri = Uri.parse(url);
      final response = await http.delete(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        final result = Repository.handleResponse(
          response,
          ResponseLD.fromJson(
            jsonData,
            (json) => fromJson(jsonData),
          ),
          jsonData,
        );

        return result;
      } else {
        throw Exception(response.body);
      }
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }
}

/// {@template ResponseLD}
/// Generic response model
/// {@endtemplate}
class ResponseLD<T> {
  /// {@macro ResponseLD}
  const ResponseLD({
    required this.message,
    this.success,
    this.body,
  });

  /// Create a [ResponseLD] from json
  factory ResponseLD.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    try {
      return ResponseLD(
        success: json['success'] != null ? json['success'] as bool : null,
        body: json['body'] != null ? fromJsonT(json['body']) : null,
        message: json['message'] != null ? json['message'] as String : null,
      );
    } on CustomException catch (e) {
      throw CustomException(
        title: 'Error en la respuesta',
        message: 'Error al parsear la respuesta: ${e.message}',
        stack: e.stack,
      );
    }
  }

  /// The response status
  final bool? success;

  /// The response body
  final T? body;

  /// The response message
  final String? message;

  /// Copy the current [ResponseLD] with some changes
  ResponseLD<T> copyWith({
    bool? estadoRespuesta,
    T? body,
    String? message,
  }) {
    return ResponseLD(
      success: success ?? this.success,
      body: body ?? this.body,
      message: message,
    );
  }

  @override
  String toString() =>
      'ResponseLD(success: $success, body: $body, message: $message)';
}

class CustomException implements Exception {
  /// {@macro CustomException}
  const CustomException({
    required this.title,
    required this.message,
    this.stack,
  });

  /// Error title.
  final String? title;

  /// Error message.
  final String? message;

  /// Stack trace of the error.
  final StackTrace? stack;
}
