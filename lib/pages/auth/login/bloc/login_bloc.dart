import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/auth/login/bloc/login_event.dart';
import 'package:guia_click/pages/auth/login/bloc/login_state.dart';
import 'package:guia_click/pages/auth/repository/auth_repository.dart';
import 'package:guia_click/services/local_storage.dart';

///
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ///
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: FormStatus.submitting));
      try {
        final response =
            await AuthRepository.login(state.email, state.password);
        await LocalStorage.setUser(user: response.body!);
        final user = await LocalStorage.getUser();
        if (user == null) {
          throw Exception('Error al guardar el usuario localmente');
        } else {
          print('Usuario guardado localmente: ${user.email}');
        }
        emit(state.copyWith(status: FormStatus.success));
      } on Exception catch (e) {
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
