part of 'bloc_manuals.dart';

/// {@template BlocDrawerState}
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocManualState {
  /// {@macro BlocDrawerState}
  const BlocManualState._({
    this.manual,
    this.ratings = const <Rating>[],
    this.myRating,
  });

  /// Utilize the from constructor to create a new instance of the
  /// [BlocManualState] class. This constructor will copy the previous
  /// state and update the values that are passed as parameters.
  BlocManualState.from(
    BlocManualState previousState, {
    Manual? manual,
    List<Rating>? ratings,
    Rating? myRating,
  }) : this._(
          manual: manual ?? previousState.manual,
          ratings: ratings ?? previousState.ratings,
          myRating: myRating ?? previousState.myRating,
        );

  /// Returns the number of pending tasks.
  final Manual? manual;
  final List<Rating> ratings;
  final Rating? myRating;
}

/// {@template BlocDrawerStateInitial}
/// Initial state of the drawer bloc.
/// {@endtemplate}
class BlocManualStateInitial extends BlocManualState {
  /// {@macro BlocDrawerStateInitial}
  BlocManualStateInitial() : super._();
}

/// {@template BlocDrawerStateLoading}
/// State when the drawer is loading.
/// {@endtemplate}
class BlocManualStateLoading extends BlocManualState {
  /// {@macro BlocDrawerStateLoading}
  BlocManualStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocDrawerStateError}
/// State when the drawer has an error.
/// {@endtemplate}
class BlocManualStateError extends BlocManualState {
  /// {@macro BlocDrawerStateError}
  BlocManualStateError.from(super.previusState) : super.from();
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocManualStateSuccess extends BlocManualState {
  /// {@macro BlocDrawerStateSuccess}
  BlocManualStateSuccess.from(
    super.previusState, {
    super.manual,
    super.ratings,
    super.myRating,
  }) : super.from();
}
