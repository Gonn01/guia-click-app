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
    try {
      return Manual(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        public: json['public'] as bool,
        createdBy: json['created_by'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
    } catch (e, st) {
      throw Exception('Error parsing Manual: $e $st $json');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'public': public,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }

  final int id;
  final String title;
  final String description;
  final String image;
  final bool public;
  final int createdBy;
  final DateTime createdAt;

  Manual copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    bool? public,
    int? createdBy,
    DateTime? createdAt,
  }) {
    return Manual(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      public: public ?? this.public,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
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
