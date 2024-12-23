import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/product_model.dart';
import 'package:topdown_store/repository/product_repo.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final ProductRepo _productRepo;
  SearchProductBloc(this._productRepo) : super(SearchProductInitial()) {
    on<SearchProduct>((event, emit) async {
      emit(SearchProductLoading());
      try {
        final product = await _productRepo.searchProduct(event.name);
        emit(SearchProductLoaded(product: product));
      } catch (e) {
        emit(SearchProductError());
      }
    });
  }
}
