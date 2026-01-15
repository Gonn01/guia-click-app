import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
import 'package:guia_click/pages/manual/manual_repository.dart';
import 'package:guia_click/services/local_storage.dart';

part 'bloc_manuals_event.dart';
part 'bloc_manuals_state.dart';

class BlocManual extends Bloc<BlocManualEvent, BlocManualState> {
  BlocManual() : super(BlocManualStateInitial()) {
    on<BlocManualEventInitialize>(_onInitialize);
    on<BlocManualEventMarkAsFavorite>(_onMarkAsFavorite);
    on<BlocManualEventMarkAsUnFavorite>(_onMarkAsUnFavorite);
    on<BlocManualsEventCreateRating>(_onCreateRating);
    on<BlocManualsEventDeleteRating>(_onDeleteRating);
    on<BlocManualEventInitializeLogged>(_onInitializeLogged);
  }

  Future<void> _onInitialize(
    BlocManualEventInitialize event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      final user = await LocalStorage.getUser();
      final manualResponse = await ManualRepository.getManualById(event.id);
      emit(
        BlocManualStateSuccess.from(
          state,
          manual: manualResponse.body,
        ),
      );
      if (user != null) {
        add(BlocManualEventInitializeLogged());
      }
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }

  Future<void> _onInitializeLogged(
    BlocManualEventInitializeLogged event,
    Emitter<BlocManualState> emit,
  ) async {
    // opcional: loading suave (si tu state lo soporta sin romper UI)
    emit(BlocManualStateLoading.from(state));

    try {
      final user = await LocalStorage.getUser();
      final userId = user?.id;

      final manualId = state.manual?.id;
      if (manualId == null || manualId == 0) {
        // si no hay manual, no seguimos
        emit(
          BlocManualStateError.from(
            state,
            'Manual inválido para cargar detalle.',
          ),
        );
        return;
      }

      final ratingsResponse = await ManualRepository.getManualRatings(manualId);
      final stepsResponse = await ManualRepository.getManualSteps(manualId);
      final isFavoriteResponse = await ManualRepository.getIfFavorite(manualId);

      final ratings = (ratingsResponse.body ?? []).toList();

      final myRating = userId == null
          ? null
          : ratings.firstWhereOrNull((r) => r.userId == userId);

      if (myRating != null) {
        ratings.removeWhere((r) => r.userId == myRating.userId);
      }

      emit(
        BlocManualStateSuccess.from(
          state,
          manual: state.manual,
          ratings: ratings,
          myRating: myRating,
          steps: stepsResponse.body ?? [],
          isFavorite: isFavoriteResponse.body ?? false,
        ),
      );
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }

  Future<void> _onMarkAsFavorite(
    BlocManualEventMarkAsFavorite event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      await ManualRepository.markAsFavorite(event.id);
      emit(BlocManualStateSuccess.from(state, isFavorite: true));
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }

  Future<void> _onMarkAsUnFavorite(
    BlocManualEventMarkAsUnFavorite event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      await ManualRepository.markAsUnFavorite(event.id);
      emit(BlocManualStateSuccess.from(state, isFavorite: false));
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }

  Future<void> _onCreateRating(
    BlocManualsEventCreateRating event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      final user = await LocalStorage.getUser();
      final userId = user?.id;
      if (userId == null) {
        emit(BlocManualStateError.from(
            state, 'Debes iniciar sesión para opinar.'));
        return;
      }

      final newRating = await ManualRepository.createRating(
        userId: userId,
        manualId: state.manual?.id ?? 0,
        score: event.rating,
        comment: event.comment,
      );

      emit(
        BlocManualStateSuccessCreatingRating.from(
          state,
          myRating: newRating.body,
        ),
      );
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }

  Future<void> _onDeleteRating(
    BlocManualsEventDeleteRating event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      final user = await LocalStorage.getUser();
      final userId = user?.id;
      final manualId = state.manual?.id;

      if (userId == null || manualId == null) {
        emit(BlocManualStateError.from(state, 'No se pudo borrar la opinión.'));
        return;
      }

      await ManualRepository.deleteRating(userId: userId, manualId: manualId);

      emit(
        BlocManualStateSuccessCreatingRating.from(
          state,
          deleteRating: true,
          myRating: null,
        ),
      );
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }
}
