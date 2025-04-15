import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
import 'package:guia_click/utilities/repository.dart';

abstract class ManualRepository {
  static Future<ResponseLD<Manual>> getManualById(int id) async {
    final response = await Repository.get<Manual>(
      url: 'http://10.0.2.2:3000/.netlify/functions/server/api/manuales/$id',
      fromJson: Manual.fromJson,
    );

    return response;
  }

  static Future<ResponseLD<List<Rating>>> getRatingsByManualId(int id) async {
    final response = await Repository.get<List<Rating>>(
      url:
          'http://10.0.2.2:3000/.netlify/functions/server/api/valoraciones/manuales/$id',
      fromJson: (json) => (json['body'] as List)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }
}
