import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
import 'package:guia_click/utilities/repository.dart';

abstract class ManualRepository {
  static Future<ResponseLD<Manual>> getManualById(int id) async {
    final response = await Repository.get<Manual>(
      url: 'http://10.0.2.2:3000/.netlify/functions/server/api/manuales/$id',
      fromJson: (json) => Manual.fromJson(json['body'] as Map<String, dynamic>),
    );

    return response;
  }

  static Future<ResponseLD<List<Rating>>> getManualRatings(int id) async {
    final response = await Repository.get<List<Rating>>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/valoraciones/manuales/$id',
      fromJson: (json) => (json['body'] as List)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<List<ManualStep>>> getManualSteps(int id) async {
    final response = await Repository.get<List<ManualStep>>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/manuals/$id/steps',
      fromJson: (json) => (json['body'] as List)
          .map((e) => ManualStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<bool>> getIfFavorite(int id) async {
    final userId = 1; // TODO: Cambiar por el id del usuario logueado
    final response = await Repository.get<bool>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/users/$userId/favorites/$id/check',
      fromJson: (json) => json['body'] as bool,
    );

    return response;
  }

  static Future<ResponseLD<void>> markAsFavorite(int id) async {
    final userId = 1; // TODO: Cambiar por el id del usuario logueado
    final response = await Repository.post<void>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/users/$userId/favorites/$id',
      fromJson: (json) {},
    );
    return response;
  }

  static Future<ResponseLD<void>> markAsUnFavorite(int id) async {
    final userId = 1; // TODO: Cambiar por el id del usuario logueado
    final response = await Repository.delete<void>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/users/$userId/favorites/$id',
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
      url: 'http://10.0.2.2:3000/.netlify/functions/server/api/ratings',
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

  static Future<ResponseLD<void>> deleteRating(int id) async {
    final userId = 1; // TODO: Cambiar por el id del usuario logueado
    final response = await Repository.delete<void>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/ratings/$userId/$id',
      fromJson: (json) {},
    );
    return response;
  }
}
