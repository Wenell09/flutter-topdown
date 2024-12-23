import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/transaction_model.dart';
import 'package:topdown_store/repository/transaction_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepo _transactionRepo;
  TransactionBloc(this._transactionRepo) : super(TransactionInitial()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await _transactionRepo.addTransaction(event.userId, event.itemId,
            event.paymentCategoryId, event.transactionTarget);
        emit(AddTransactionSuccess());
        add(GetTransaction(userId: event.userId));
      } catch (e) {
        emit(TransactionError());
      }
    });

    on<TopUpTopay>((event, emit) async {
      emit(TransactionLoading());
      try {
        await _transactionRepo.topUpTopay(event.userId, event.itemId,
            event.paymentCategoryId, event.transactionTarget);
        emit(AddTransactionSuccess());
        add(GetTransaction(userId: event.userId));
      } catch (e) {
        emit(TransactionError());
      }
    });

    on<GetTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transaction = await _transactionRepo.getTransaction(event.userId);
        emit(TransactionLoaded(transaction: transaction));
      } catch (e) {
        emit(TransactionError());
      }
    });
  }
}
