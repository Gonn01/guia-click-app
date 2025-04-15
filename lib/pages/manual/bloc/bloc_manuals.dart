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
  }
  Future<void> _onInitialize(
    BlocManualEventInitialize event,
    Emitter<BlocManualState> emit,
  ) async {
    emit(BlocManualStateLoading.from(state));
    try {
      final manualResponse = await ManualRepository.getManualById(event.id);

      final ratingsResponse = await ManualRepository.getRatingsByManualId(
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
        ),
      );
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state, e.toString()));
    }
  }
}
