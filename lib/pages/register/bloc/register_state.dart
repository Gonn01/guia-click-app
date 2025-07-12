import 'package:equatable/equatable.dart';

enum FormStatus { initial, submitting, success, failure }

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final FormStatus status;
  final String? errorMessage;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    FormStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [name, email, password, status, errorMessage];
}
