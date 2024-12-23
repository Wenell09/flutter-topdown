import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_item_event.dart';
part 'select_item_state.dart';

class SelectItemBloc extends Bloc<SelectItemEvent, SelectItemState> {
  SelectItemBloc()
      : super(SelectItemState(itemId: "", itemName: "", itemPrice: 0)) {
    on<AddSelectItem>((event, emit) {
      debugPrint("item yang dipilih:${event.itemName}");
      emit(SelectItemState(
        itemId: event.itemId,
        itemName: event.itemName,
        itemPrice: event.itemPrice,
      ));
    });
  }
}
