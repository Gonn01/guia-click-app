class Manual {
  Manual({
    required this.id,
    required this.title,
    required this.description,
    required this.public,
    required this.createdBy,
    required this.createdAt,
    required this.steps,
  });

  factory Manual.fromJson(Map<String, dynamic> json) {
    return Manual(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      public: json['public'] as bool,
      createdBy: json['created_by'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => ManualStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'public': public,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'steps': steps.map((e) => e.toJson()).toList(),
    };
  }

  final int id;
  final String title;
  final String description;
  final bool public;
  final int createdBy;
  final DateTime createdAt;
  final List<ManualStep> steps;

  Manual copyWith({
    int? id,
    String? title,
    String? description,
    bool? public,
    int? createdBy,
    DateTime? createdAt,
    List<ManualStep>? steps,
  }) {
    return Manual(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      public: public ?? this.public,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      steps: steps ?? this.steps,
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
