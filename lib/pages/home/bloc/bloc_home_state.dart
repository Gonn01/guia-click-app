part of 'bloc_home.dart';

/// {@template BlocDrawerState}
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocHomeState {
  /// {@macro BlocDrawerState}
  const BlocHomeState._({
    this.companyCode,
  });

  /// Utilize the from constructor to create a new instance of the
  /// [BlocHomeState] class. This constructor will copy the previous
  /// state and update the values that are passed as parameters.
  BlocHomeState.from(
    BlocHomeState previousState, {
    String? companyCode,
  }) : this._(
          companyCode: companyCode ?? previousState.companyCode,
        );

  /// Returns the number of pending tasks.
  final String? companyCode;
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
  BlocHomeStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocDrawerStateError}
/// State when the drawer has an error.
/// {@endtemplate}
class BlocHomeStateError extends BlocHomeState {
  /// {@macro BlocDrawerStateError}
  BlocHomeStateError.from(super.previusState, this.error) : super.from();
  final String error;
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccess extends BlocHomeState {
  /// {@macro BlocDrawerStateSuccess}
  BlocHomeStateSuccess.from(
    super.previusState, {
    super.companyCode,
  }) : super.from();
}

/// {@template BlocDrawerStateSuccess}
/// State when the drawer is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccessSavingCompanyCode extends BlocHomeState {
  /// {@macro BlocDrawerStateSuccess}
  BlocHomeStateSuccessSavingCompanyCode.from(super.previusState) : super.from();
}
