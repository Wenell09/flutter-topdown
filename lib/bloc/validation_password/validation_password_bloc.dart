import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validation_password_event.dart';
part 'validation_password_state.dart';

class ValidationPasswordBloc
    extends Bloc<ValidationPasswordEvent, ValidationPasswordState> {
  ValidationPasswordBloc()
      : super(ValidationPasswordState(hideShowPassword: true)) {
    on<ShowPassword>((event, emit) {
      emit(ValidationPasswordState(hideShowPassword: event.hideShowPassword));
    });
  }
}
