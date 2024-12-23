part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthRegisterSuccess extends AuthState {
  final String userId;
  AuthRegisterSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class AuthLoginSuccess extends AuthState {
  final String userId;
  AuthLoginSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
  @override
  List<Object?> get props => [error];
}
