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

class ConfirmTransaction extends TransactionEvent {
  final String userId, transactionId;
  ConfirmTransaction({
    required this.userId,
    required this.transactionId,
  });
  @override
  List<Object?> get props => [userId, transactionId];
}

class ConfirmTopUpTopay extends TransactionEvent {
  final String userId, transactionId, adminId, itemId;
  ConfirmTopUpTopay({
    required this.userId,
    required this.transactionId,
    required this.adminId,
    required this.itemId,
  });
  @override
  List<Object?> get props => [
        userId,
        transactionId,
        adminId,
        itemId,
      ];
}
