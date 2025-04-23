import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

/// {@template BlocHome}
/// Bloc that manages the states and logic of the 'ProfileSummary' page
/// {@endtemplate}
class BlocHome extends Bloc<BlocHomeEvent, BlocHomeState> {
  /// {@macro BlocHome}
  BlocHome() : super(BlocHomeStateInitial()) {
    on<BlocHomeEventInitialize>(_onInitialize);
    on<BlocHomeEventSaveCompanyCode>(_onSaveCompanyCode);
  }
  Future<void> _onInitialize(
    BlocHomeEventInitialize event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      final preferences = await SharedPreferences.getInstance();
      final companyCode = preferences.getString('companyCode');
      emit(
        BlocHomeStateSuccess.from(
          state,
          companyCode: companyCode,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, e.toString()));
    }
  }

  Future<void> _onSaveCompanyCode(
    BlocHomeEventSaveCompanyCode event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('companyCode', event.companyCode ?? '');

      emit(BlocHomeStateSuccessSavingCompanyCode.from(state));
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, e.toString()));
    }
  }
}
