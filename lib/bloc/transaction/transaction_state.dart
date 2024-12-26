part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {}

final class TransactionInitial extends TransactionState {
  @override
  List<Object?> get props => [];
}

final class TransactionLoading extends TransactionState {
  @override
  List<Object?> get props => [];
}

final class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transaction;
  TransactionLoaded({required this.transaction});
  @override
  List<Object?> get props => [transaction];
}

final class AddTransactionSuccess extends TransactionState {
  @override
  List<Object?> get props => [];
}

final class ConfirmTransactionSuccess extends TransactionState {
  @override
  List<Object?> get props => [];
}

final class ConfirmTopUpTopaySuccess extends TransactionState {
  @override
  List<Object?> get props => [];
}

final class TransactionError extends TransactionState {
  @override
  List<Object?> get props => [];
}
