part of 'bloc_home.dart';

/// {@template BlocDrawerEvent}
/// Defines the events that can occur on the ProfileSettings page.
/// {@endtemplate}
abstract class BlocHomeEvent {
  /// {@macro BlocDrawerEvent}
  const BlocHomeEvent();
}

/// {@template BlocDrawerEventCheckManual}
/// Check the pending tasks of the user.
/// {@endtemplate}
class BlocHomeEventInitialize extends BlocHomeEvent {}

/// {@template BlocDrawerEventCheckManual}
/// Check the pending tasks of the user.
/// {@endtemplate}
class BlocHomeEventSaveCompanyCode extends BlocHomeEvent {
  /// {@macro BlocDrawerEventCheckManual}
  const BlocHomeEventSaveCompanyCode(this.companyCode);
  final String? companyCode;
}
