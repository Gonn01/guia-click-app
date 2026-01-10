// ==========================
// lib/models/manual.dart
// (versión tolerante para Algolia)
// ==========================
class Manual {
  Manual({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.public,
    required this.createdBy,
    required this.createdAt,
  });

  factory Manual.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v, {int fallback = 0}) {
      if (v == null) return fallback;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v) ?? fallback;
      return fallback;
    }

    bool parseBool(dynamic v, {bool fallback = false}) {
      if (v == null) return fallback;
      if (v is bool) return v;
      if (v is num) return v != 0;
      if (v is String) {
        final s = v.toLowerCase().trim();
        return s == 'true' || s == '1' || s == 'yes';
      }
      return fallback;
    }

    DateTime parseDate(dynamic v) {
      if (v is String)
        return DateTime.tryParse(v) ?? DateTime.fromMillisecondsSinceEpoch(0);
      return DateTime.fromMillisecondsSinceEpoch(0);
    }

    return Manual(
      // Algolia a veces usa objectID además de id
      id: parseInt(json['id'] ?? json['objectID']),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      public: parseBool(json['public'], fallback: true),
      // Puede no venir en Algolia (tenías author), queda 0
      createdBy: parseInt(json['created_by'] ?? json['createdBy'], fallback: 0),
      createdAt: parseDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'public': public,
        'created_by': createdBy,
        'created_at': createdAt.toIso8601String(),
      };

  final int id;
  final String title;
  final String description;
  final String image;
  final bool public;
  final int createdBy;
  final DateTime createdAt;
}

class ManualStep {
  ManualStep({
    required this.id,
    required this.manualId,
    required this.order,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.image,
  });

  factory ManualStep.fromJson(Map<String, dynamic> json) {
    return ManualStep(
      id: json['id'] as int,
      manualId: json['manual_id'] as int,
      order: json['order'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manual_id': manualId,
      'order': order,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'image': image,
    };
  }

  final int id;
  final int manualId;
  final int order;
  final String title;
  final String description;
  final DateTime createdAt;
  final String image;

  ManualStep copyWith({
    int? id,
    int? manualId,
    int? order,
    String? title,
    String? description,
    DateTime? createdAt,
    String? image,
  }) {
    return ManualStep(
      id: id ?? this.id,
      manualId: manualId ?? this.manualId,
      order: order ?? this.order,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }
}
