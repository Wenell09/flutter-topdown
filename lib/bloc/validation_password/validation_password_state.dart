part of 'validation_password_bloc.dart';

class ValidationPasswordState extends Equatable {
  final bool hideShowPassword;
  // ignore: prefer_const_constructors_in_immutables
  ValidationPasswordState({required this.hideShowPassword});
  @override
  List<Object> get props => [hideShowPassword];
}
