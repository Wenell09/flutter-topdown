part of 'select_payment_bloc.dart';

class SelectPaymentState extends Equatable {
  final String paymentCategoryId, paymentName;
  // ignore: prefer_const_constructors_in_immutables
  SelectPaymentState(
      {required this.paymentCategoryId, required this.paymentName});
  @override
  List<Object?> get props => [paymentCategoryId, paymentName];
}
