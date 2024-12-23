part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class GetUser extends UserEvent {
  final String userId;
  GetUser({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class EditUser extends UserEvent {
  final String userId, username, email, password;
  EditUser({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [userId, username, email, password];
}

class DeleteUser extends UserEvent {
  final String userId;
  DeleteUser({required this.userId});
  @override
  List<Object?> get props => [userId];
}
