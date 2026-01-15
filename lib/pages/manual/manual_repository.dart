import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
import 'package:guia_click/services/local_storage.dart';
import 'package:guia_click/utilities/repository.dart';

abstract class ManualRepository {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  static Future<ResponseLD<Manual>> getManualById(int id) async {
    final response = await Repository.get<Manual>(
      url: '$_baseUrl/api/manuales/$id',
      fromJson: (json) => Manual.fromJson(json['body'] as Map<String, dynamic>),
    );
    return response;
  }

  static Future<ResponseLD<List<Rating>>> getManualRatings(int id) async {
    final response = await Repository.get<List<Rating>>(
      url: '$_baseUrl/api/valoraciones/manuales/$id',
      fromJson: (json) => (json['body'] as List)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return response;
  }

  static Future<ResponseLD<List<ManualStep>>> getManualSteps(int id) async {
    final response = await Repository.get<List<ManualStep>>(
      url: '$_baseUrl/api/manuals/$id/steps',
      fromJson: (json) => (json['body'] as List)
          .map((e) => ManualStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return response;
  }

  static Future<ResponseLD<bool>> getIfFavorite(int manualId) async {
    final user = await LocalStorage.getUser();
    final response = await Repository.get<bool>(
      url: '$_baseUrl/api/users/${user?.id}/favorites/$manualId/check',
      fromJson: (json) => json['body'] as bool,
    );
    return response;
  }

  static Future<ResponseLD<void>> markAsFavorite(int manualId) async {
    final user = await LocalStorage.getUser();
    final response = await Repository.post<void>(
      url: '$_baseUrl/api/users/${user?.id}/favorites/$manualId',
      fromJson: (json) {},
    );
    return response;
  }

  static Future<ResponseLD<void>> markAsUnFavorite(int manualId) async {
    final user = await LocalStorage.getUser();
    final response = await Repository.delete<void>(
      url: '$_baseUrl/api/users/${user?.id}/favorites/$manualId',
      fromJson: (json) {},
    );
    return response;
  }

  static Future<ResponseLD<Rating>> createRating({
    required int userId,
    required int manualId,
    required int score,
    required String comment,
  }) async {
    final response = await Repository.post<Rating>(
      url: '$_baseUrl/api/ratings',
      fromJson: (json) => Rating.fromJson(json['body'] as Map<String, dynamic>),
      additionalKeys: {
        'score': score,
        'comment': comment,
        'user_id': userId,
        'manual_id': manualId,
      },
    );
    return response;
  }

  // ✅ Postman: DELETE /api/ratings/:userId/:manualId
  static Future<ResponseLD<void>> deleteRating({
    required int userId,
    required int manualId,
  }) async {
    final response = await Repository.delete<void>(
      url: '$_baseUrl/api/ratings/$userId/$manualId',
      fromJson: (json) {},
    );
    return response;
  }

  static Future<ResponseLD<List<Manual>>> getFavorites() async {
    final user = await LocalStorage.getUser();
    final response = await Repository.get<List<Manual>>(
      url: '$_baseUrl/api/users/${user?.id}/favorites',
      fromJson: (json) => (json['body'] as List)
          .map((e) => Manual.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return response;
  }
}
