part of 'validation_password_bloc.dart';

sealed class ValidationPasswordEvent extends Equatable {}

class ShowPassword extends ValidationPasswordEvent {
  final bool hideShowPassword;
  ShowPassword({required this.hideShowPassword});
  @override
  List<Object?> get props => [hideShowPassword];
}
