part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

class Register extends AuthEvent {
  final String username, email, password;
  Register(
      {required this.username, required this.email, required this.password});
  @override
  List<Object?> get props => [username, email, password];
}

class Login extends AuthEvent {
  final String email, password;
  Login({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
