import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
import 'package:guia_click/pages/manual/manual_repository.dart';
part 'bloc_manuals_event.dart';
part 'bloc_manuals_state.dart';

/// {@template BlocManual}
/// Bloc that manages the states and logic of the 'ProfileSummary' page
/// {@endtemplate}
class BlocManual extends Bloc<BlocManualEvent, BlocManualState> {
  /// {@macro BlocManual}
  BlocManual() : super(BlocManualStateInitial()) {
    on<BlocManualEventInitialize>(_onInitialize);
    on<BlocManualEventMarkAsFavorite>(_onMarkAsFavorite);
    on<BlocManualEventMarkAsUnFavorite>(_onMarkAsUnFavorite);
    on<BlocManualsEventCreateRating>(_onCreateRating);
    on<BlocManualsEventDeleteRating>(_onDeleteRating);
  }
  Future<void> _onInitialize(
    BlocManualEventInitialize event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      final manualResponse = await ManualRepository.getManualById(event.id);

      final ratingsResponse = await ManualRepository.getManualRatings(
        manualResponse.body?.id ?? 0,
      );

      final steps = await ManualRepository.getManualSteps(
        manualResponse.body?.id ?? 0,
      );

      final isFavorite = await ManualRepository.getIfFavorite(
        manualResponse.body?.id ?? 0,
      );

      final ratings = ratingsResponse.body ?? [];

      final myRating = ratings.firstWhereOrNull(
        (element) => element.userId == 1,
      );

      if (myRating != null) {
        ratings.removeWhere(
          (element) => element.userId == myRating.userId,
        );
      }

      emit(
        BlocManualStateSuccess.from(
          state,
          manual: manualResponse.body,
          ratings: ratings,
          myRating: myRating,
          steps: steps.body ?? [],
          isFavorite: isFavorite.body ?? false,
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
      emit(
        BlocManualStateSuccess.from(
          state,
          isFavorite: true,
        ),
      );
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
      emit(
        BlocManualStateSuccess.from(
          state,
          isFavorite: false,
        ),
      );
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
      final newRating = await ManualRepository.createRating(
        userId: 1,
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
      await ManualRepository.deleteRating(event.ratingId);
      emit(
          BlocManualStateSuccessCreatingRating.from(state, deleteRating: true));
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }
}
