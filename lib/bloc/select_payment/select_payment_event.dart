part of 'select_payment_bloc.dart';

sealed class SelectPaymentEvent extends Equatable {}

class ChangeSelectPayment extends SelectPaymentEvent {
  final String paymentCategoryId, paymentName;
  ChangeSelectPayment(
      {required this.paymentCategoryId, required this.paymentName});
  @override
  List<Object?> get props => [paymentCategoryId, paymentName];
}
