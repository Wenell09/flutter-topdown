import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_category_event.dart';
part 'select_category_state.dart';

class SelectCategoryBloc
    extends Bloc<SelectCategoryEvent, SelectCategoryState> {
  // ignore: prefer_const_constructors
  SelectCategoryBloc() : super(SelectCategoryState(categoryId: "")) {
    on<SelectCategory>((event, emit) {
      emit(SelectCategoryState(categoryId: event.categoryId));
    });
  }
}
