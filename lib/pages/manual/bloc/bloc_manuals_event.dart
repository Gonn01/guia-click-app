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

class BlocManualEventTurnFavorite extends BlocManualEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocManualEventTurnFavorite(this.id);
  final int id;
}
