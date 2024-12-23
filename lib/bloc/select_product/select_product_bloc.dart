import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_product_event.dart';
part 'select_product_state.dart';

class SelectProductBloc extends Bloc<SelectProductEvent, SelectProductState> {
  SelectProductBloc() : super(SelectProductState(index: 0)) {
    on<SelectProduct>((event, emit) {
      emit(SelectProductState(index: event.index));
    });
  }
}
