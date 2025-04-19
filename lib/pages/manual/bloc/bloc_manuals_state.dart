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
    this.isFavorite = false,
    this.steps = const <ManualStep>[],
  });

  /// Utilize the from constructor to create a new instance of the
  /// [BlocManualState] class. This constructor will copy the previous
  /// state and update the values that are passed as parameters.
  BlocManualState.from(
    BlocManualState previousState, {
    Manual? manual,
    List<Rating>? ratings,
    Rating? myRating,
    bool? isFavorite,
    List<ManualStep>? steps,
    bool deleteRating = false,
  }) : this._(
          manual: manual ?? previousState.manual,
          ratings: ratings ?? previousState.ratings,
          myRating: deleteRating ? null : myRating ?? previousState.myRating,
          isFavorite: isFavorite ?? previousState.isFavorite,
          steps: steps ?? previousState.steps,
        );

  /// Returns the number of pending tasks.
  final Manual? manual;
  final List<Rating> ratings;
  final List<ManualStep> steps;
  final Rating? myRating;
  final bool isFavorite;
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
  BlocManualStateError.from(super.previusState, this.error) : super.from();
  final String error;
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
    super.isFavorite,
    super.steps,
  }) : super.from();
}

class BlocManualStateSuccessCreatingRating extends BlocManualState {
  /// {@macro BlocDrawerStateSuccess}
  BlocManualStateSuccessCreatingRating.from(
    super.previusState, {
    super.myRating,
    super.deleteRating,
  }) : super.from();
}
