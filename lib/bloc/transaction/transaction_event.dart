part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {}

class AddTransaction extends TransactionEvent {
  final String userId, itemId, paymentCategoryId, transactionTarget;
  AddTransaction({
    required this.userId,
    required this.itemId,
    required this.paymentCategoryId,
    required this.transactionTarget,
  });
  @override
  List<Object?> get props => [
        userId,
        itemId,
        paymentCategoryId,
        transactionTarget,
      ];
}

class TopUpTopay extends TransactionEvent {
  final String userId, itemId, paymentCategoryId, transactionTarget;
  TopUpTopay({
    required this.userId,
    required this.itemId,
    required this.paymentCategoryId,
    required this.transactionTarget,
  });
  @override
  List<Object?> get props => [
        userId,
        itemId,
        paymentCategoryId,
        transactionTarget,
      ];
}

class GetTransaction extends TransactionEvent {
  final String userId;
  GetTransaction({required this.userId});
  @override
  List<Object?> get props => [userId];
}
