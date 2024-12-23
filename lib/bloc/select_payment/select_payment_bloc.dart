import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'select_payment_event.dart';
part 'select_payment_state.dart';

class SelectPaymentBloc extends Bloc<SelectPaymentEvent, SelectPaymentState> {
  SelectPaymentBloc()
      : super(SelectPaymentState(paymentCategoryId: "", paymentName: "")) {
    on<ChangeSelectPayment>((event, emit) {
      debugPrint(
          "select payment:${event.paymentCategoryId},${event.paymentName}");
      emit(SelectPaymentState(
          paymentCategoryId: event.paymentCategoryId,
          paymentName: event.paymentName));
    });
  }
}
