part of 'user_bloc.dart';

sealed class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoaded extends UserState {
  final List<UserModel> user;
  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

final class EditUserSuccess extends UserState {
  @override
  List<Object?> get props => [];
}

final class DeleteUserSuccess extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserError extends UserState {
  @override
  List<Object?> get props => [];
}
