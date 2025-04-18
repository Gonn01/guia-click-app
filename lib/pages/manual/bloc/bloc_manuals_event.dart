part of 'bloc_manuals.dart';

/// {@template BlocDrawerEvent}
/// Defines the events that can occur on the ProfileSettings page.
/// {@endtemplate}
abstract class BlocManualEvent {
  /// {@macro BlocDrawerEvent}
  const BlocManualEvent();
}

/// {@template BlocDrawerEventCheckManual}
/// Check the pending tasks of the user.
/// {@endtemplate}
class BlocManualEventInitialize extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualEventInitialize(this.id);
  final int id;
}

class BlocManualEventMarkAsFavorite extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualEventMarkAsFavorite(this.id);
  final int id;
}

class BlocManualEventMarkAsUnFavorite extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualEventMarkAsUnFavorite(this.id);
  final int id;
}

class BlocManualsEventCreateRating extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualsEventCreateRating({
    required this.rating,
    required this.comment,
  });
  final int rating;
  final String comment;
}

class BlocManualsEventDeleteRating extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualsEventDeleteRating(this.ratingId);
  final int ratingId;
}
