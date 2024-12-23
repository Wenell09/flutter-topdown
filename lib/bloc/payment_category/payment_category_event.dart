part of 'payment_category_bloc.dart';

sealed class PaymentCategoryEvent extends Equatable {}

class GetPaymentCategory extends PaymentCategoryEvent {
  @override
  List<Object?> get props => [];
}
