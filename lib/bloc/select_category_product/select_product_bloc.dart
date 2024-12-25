import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_product_event.dart';
part 'select_product_state.dart';

class SelectCategoryProductBloc
    extends Bloc<SelectCategoryProductEvent, SelectCategoryProductState> {
  SelectCategoryProductBloc() : super(SelectCategoryProductState(index: 0)) {
    on<SelectCategoryProduct>((event, emit) {
      emit(SelectCategoryProductState(index: event.index));
    });
  }
}
