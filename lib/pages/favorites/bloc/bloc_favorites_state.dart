part of 'bloc_favorites.dart';

/// {@template BlocDrawerState}
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFavoritesState {
  /// {@macro BlocDrawerState}
  const BlocFavoritesState._({
    this.favoriteManuals = const [],
  });

  /// Utilize the from constructor to create a new instance of the
  /// [BlocFavoritesState] class. This constructor will copy the previous
  /// state and update the values that are passed as parameters.
  BlocFavoritesState.from(
    BlocFavoritesState previousState, {
    List<Manual>? favoriteManuals,
  }) : this._(
          favoriteManuals: favoriteManuals ?? previousState.favoriteManuals,
        );

  /// Returns the number of pending tasks.
  final List<Manual> favoriteManuals;
}

/// {@template BlocDrawerStateInitial}
/// Initial state of the drawer bloc.
/// {@endtemplate}
class BlocFavoritesStateInitial extends BlocFavoritesState {
  /// {@macro BlocDrawerStateInitial}
  BlocFavoritesStateInitial() : super._();
}

/// {@template BlocDrawerStateLoading}
/// State when the drawer is loading.
/// {@endtemplate}
class BlocFavoritesStateLoading extends BlocFavoritesState {
  /// {@macro BlocDrawerStateLoading}
  BlocFavoritesStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocDrawerStateError}
/// State when the drawer has an error.
/// {@endtemplate}
class BlocFavoritesStateError extends BlocFavoritesState {
  /// {@macro BlocDrawerStateError}
  BlocFavoritesStateError.from(super.previusState, this.error) : super.from();
  final String error;
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocFavoritesStateSuccess extends BlocFavoritesState {
  /// {@macro BlocDrawerStateSuccess}
  BlocFavoritesStateSuccess.from(
    super.previusState, {
    super.favoriteManuals,
  }) : super.from();
}
