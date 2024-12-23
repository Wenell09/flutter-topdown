import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/payment_category_model.dart';
import 'package:topdown_store/repository/payment_category_repo.dart';

part 'payment_category_event.dart';
part 'payment_category_state.dart';

class PaymentCategoryBloc
    extends Bloc<PaymentCategoryEvent, PaymentCategoryState> {
  final PaymentCategoryRepo _paymentCategoryRepo;
  PaymentCategoryBloc(this._paymentCategoryRepo)
      : super(PaymentCategoryInitial()) {
    on<GetPaymentCategory>((event, emit) async {
      emit(PaymentCategoryLoading());
      try {
        final paymentCategory = await _paymentCategoryRepo.getPaymentCategory();
        emit(PaymentCategoryLoaded(paymentCategory: paymentCategory));
      } catch (e) {
        emit(PaymentCategoryError());
      }
    });
  }
}
