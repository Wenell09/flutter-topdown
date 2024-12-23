import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/user_model.dart';
import 'package:topdown_store/repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  UserBloc(this._userRepo) : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await _userRepo.getAccount(event.userId);
        emit(UserLoaded(user: user));
      } catch (e) {
        emit(UserError());
      }
    });
    on<EditUser>((event, emit) async {
      emit(UserLoading());
      try {
        await _userRepo.editAccount(
          event.userId,
          event.username,
          event.email,
          event.password,
        );
        emit(EditUserSuccess());
        add(GetUser(userId: event.userId));
      } catch (e) {
        emit(UserError());
      }
    });
    on<DeleteUser>((event, emit) async {
      try {
        await _userRepo.deleteAccount(event.userId);
        emit(DeleteUserSuccess());
        add(GetUser(userId: event.userId));
      } catch (e) {
        emit(UserError());
      }
    });
  }
}
