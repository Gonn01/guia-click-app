import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/rating.dart';
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
      final ratings = [
        Rating(
          id: 0,
          userId: 1,
          manualId: 0,
          rating: 4,
          comment:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
          createdAt: DateTime.now(),
        ),
        Rating(
          id: 1,
          userId: 2,
          manualId: 0,
          rating: 4,
          comment:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
          createdAt: DateTime.now(),
        ),
        Rating(
          id: 2,
          userId: 3,
          manualId: 0,
          rating: 4,
          comment:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
          createdAt: DateTime.now(),
        ),
        Rating(
          id: 3,
          userId: 4,
          manualId: 0,
          rating: 4,
          comment:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
          createdAt: DateTime.now(),
        ),
      ];
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
          manual: Manual(
            id: 0,
            title: 'Test',
            description:
                'Lorem Ipsronic typesettily with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets ',
            public: true,
            createdBy: 1,
            createdAt: DateTime.now(),
            steps: [
              ManualStep(
                id: 0,
                manualId: 1,
                order: 0,
                title: 'title',
                description: 'description',
                createdAt: DateTime.now(),
                image:
                    'https://cdn-icons-png.flaticon.com/512/1568/1568401.png',
              ),
              ManualStep(
                id: 1,
                manualId: 1,
                order: 1,
                title: 'title',
                description: 'descriptiondescription',
                createdAt: DateTime.now(),
                image:
                    'https://cdn-icons-png.flaticon.com/512/1568/1568401.png',
              ),
              ManualStep(
                id: 2,
                manualId: 1,
                order: 2,
                title: 'title',
                description: 'descriptiondescriptiondescriptiondescription',
                createdAt: DateTime.now(),
                image:
                    'https://cdn-icons-png.flaticon.com/512/1568/1568401.png',
              ),
            ],
          ),
          ratings: ratings,
          myRating: myRating,
        ),
      );
    } on Exception catch (e) {
      emit(BlocManualStateError.from(state));
    }
  }
}
