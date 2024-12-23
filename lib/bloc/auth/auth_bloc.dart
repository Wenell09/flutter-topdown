import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<Register>((event, emit) async {
      emit(AuthLoading());
      try {
        if (event.username.isEmpty ||
            event.email.isEmpty ||
            event.password.isEmpty) {
          emit(AuthError(error: "Pastikan semua field telah terisi!"));
          return;
        }
        final userId = await _authRepo.addAccount(
            event.username, event.email, event.password);
        emit(AuthRegisterSuccess(userId: userId));
      } catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        emit(AuthError(error: errorMessage));
      }
    });

    on<Login>((event, emit) async {
      emit(AuthLoading());
      try {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(AuthError(error: "Pastikan semua field telah terisi!"));
          return;
        }
        final userId =
            await _authRepo.loginAccount(event.email, event.password);

        emit(AuthLoginSuccess(userId: userId));
      } catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        emit(AuthError(error: errorMessage));
      }
    });
  }
}
