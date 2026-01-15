part of 'bloc_home.dart';

/// {@template BlocDrawerState}
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocHomeState {
  /// {@macro BlocDrawerState}
  const BlocHomeState._({
    this.user,
  });

  /// Utilize the from constructor to create a new instance of the
  /// [BlocHomeState] class. This constructor will copy the previous
  /// state and update the values that are passed as parameters.
  BlocHomeState.from(
    BlocHomeState previousState, {
    User? user,
  }) : this._(
          user: user ?? previousState.user,
        );

  /// Returns the number of pending tasks.
  final User? user;
}

/// {@template BlocDrawerStateInitial}
/// Initial state of the drawer bloc.
/// {@endtemplate}
class BlocHomeStateInitial extends BlocHomeState {
  /// {@macro BlocDrawerStateInitial}
  BlocHomeStateInitial() : super._();
}

/// {@template BlocDrawerStateLoading}
/// State when the drawer is loading.
/// {@endtemplate}
class BlocHomeStateLoading extends BlocHomeState {
  /// {@macro BlocDrawerStateLoading}
  BlocHomeStateLoading.from(super.previousState) : super.from();
}

/// {@template BlocDrawerStateError}
/// State when the drawer has an error.
/// {@endtemplate}
class BlocHomeStateError extends BlocHomeState {
  /// {@macro BlocDrawerStateError}
  BlocHomeStateError.from(super.previousState, this.error) : super.from();
  final String error;
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccess extends BlocHomeState {
  /// {@macro BlocDrawerStateSuccess}
  BlocHomeStateSuccess.from(
    super.previousState, {
    super.user,
  }) : super.from();
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccessSavingCompanyCode extends BlocHomeState {
  /// {@macro BlocDrawerStateSuccess}
  BlocHomeStateSuccessSavingCompanyCode.from(super.previousState)
      : super.from();
}
