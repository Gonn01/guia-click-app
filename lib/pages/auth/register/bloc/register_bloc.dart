import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/auth_repository.dart';
import 'package:guia_click/pages/auth/register/bloc/register_event.dart';
import 'package:guia_click/pages/auth/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(status: FormStatus.submitting));
      try {
        final success = await AuthRepository.register(
          state.name,
          state.email,
          state.password,
        );
        if (success.body == true) {
          emit(state.copyWith(status: FormStatus.success));
        } else {
          emit(
            state.copyWith(
              status: FormStatus.failure,
              errorMessage: 'Registration failed',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: FormStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
