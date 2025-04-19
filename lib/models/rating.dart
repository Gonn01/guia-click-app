class Rating {
  const Rating({
    required this.id,
    required this.userId,
    required this.manualId,
    required this.score,
    required this.comment,
    required this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      manualId: json['manual_id'] as int,
      score: json['score'] as int,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'manual_id': manualId,
      'score': score,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  final int id;
  final int userId;
  final int manualId;
  final int score;
  final String comment;
  final DateTime createdAt;

  Rating copyWith({
    int? id,
    int? userId,
    int? manualId,
    int? score,
    String? comment,
    DateTime? createdAt,
  }) {
    return Rating(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      manualId: manualId ?? this.manualId,
      score: score ?? this.score,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
