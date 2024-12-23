part of 'payment_category_bloc.dart';

sealed class PaymentCategoryState extends Equatable {}

final class PaymentCategoryInitial extends PaymentCategoryState {
  @override
  List<Object?> get props => [];
}

final class PaymentCategoryLoading extends PaymentCategoryState {
  @override
  List<Object?> get props => [];
}

final class PaymentCategoryLoaded extends PaymentCategoryState {
  final List<PaymentCategoryModel> paymentCategory;
  PaymentCategoryLoaded({required this.paymentCategory});
  @override
  List<Object?> get props => [paymentCategory];
}

final class PaymentCategoryError extends PaymentCategoryState {
  @override
  List<Object?> get props => [];
}
