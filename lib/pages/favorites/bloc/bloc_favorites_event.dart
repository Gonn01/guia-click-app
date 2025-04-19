part of 'bloc_favorites.dart';

/// {@template BlocDrawerEvent}
/// Defines the events that can occur on the ProfileSettings page.
/// {@endtemplate}
abstract class BlocFavoritesEvent {
  /// {@macro BlocDrawerEvent}
  const BlocFavoritesEvent();
}

/// {@template BlocDrawerEventCheckManual}
/// Check the pending tasks of the user.
/// {@endtemplate}
class BlocFavoritesEventInitialize extends BlocFavoritesEvent {}
