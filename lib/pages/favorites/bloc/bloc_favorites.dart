import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/pages/manual/manual_repository.dart';
part 'bloc_favorites_event.dart';
part 'bloc_favorites_state.dart';

/// {@template BlocFavorites}
/// Bloc that manages the states and logic of the 'ProfileSummary' page
/// {@endtemplate}
class BlocFavorites extends Bloc<BlocFavoritesEvent, BlocFavoritesState> {
  /// {@macro BlocFavorites}
  BlocFavorites() : super(BlocFavoritesStateInitial()) {
    on<BlocFavoritesEventInitialize>(_onInitialize);
  }
  Future<void> _onInitialize(
    BlocFavoritesEventInitialize event,
    Emitter<BlocFavoritesState> emit,
  ) async {
    emit(BlocFavoritesStateLoading.from(state));
    try {
      final manualResponse = await ManualRepository.getFavorites();

      emit(
        BlocFavoritesStateSuccess.from(
          state,
          favoriteManuals: manualResponse.body,
        ),
      );
    } on Exception catch (e) {
      emit(BlocFavoritesStateError.from(state, e.toString()));
    }
  }
}
