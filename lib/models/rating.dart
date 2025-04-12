class Rating {
  const Rating({
    required this.id,
    required this.userId,
    required this.manualId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      manualId: json['manual_id'] as int,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'manual_id': manualId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  final int id;
  final int userId;
  final int manualId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  Rating copyWith({
    int? id,
    int? userId,
    int? manualId,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return Rating(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      manualId: manualId ?? this.manualId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
