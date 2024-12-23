import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/product_model.dart';
import 'package:topdown_store/repository/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  ProductBloc(this._productRepo) : super(ProductInitial()) {
    on<GetProductGames>((event, emit) async {
      emit(ProductLoading());
      try {
        final games = await _productRepo.getProduct(event.categoryId);
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(games: games));
        } else {
          emit(
            ProductLoaded(
              games: games,
              entertainment: const [],
              tagihan: const [],
              allProduct: const [],
            ),
          );
        }
      } catch (e) {
        emit(ProductError());
      }
    });
    on<GetProductEntertainment>((event, emit) async {
      emit(ProductLoading());
      try {
        final entertainment = await _productRepo.getProduct(event.categoryId);
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(entertainment: entertainment));
        } else {
          emit(
            ProductLoaded(
              games: const [],
              entertainment: entertainment,
              tagihan: const [],
              allProduct: const [],
            ),
          );
        }
      } catch (e) {
        emit(ProductError());
      }
    });
    on<GetProductTagihan>((event, emit) async {
      emit(ProductLoading());
      try {
        final tagihan = await _productRepo.getProduct(event.categoryId);
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(tagihan: tagihan));
        } else {
          emit(
            ProductLoaded(
              games: const [],
              entertainment: const [],
              tagihan: tagihan,
              allProduct: const [],
            ),
          );
        }
      } catch (e) {
        emit(ProductError());
      }
    });
    on<GetProductByCategoryId>((event, emit) async {
      emit(ProductLoading());
      try {
        final allProduct = await _productRepo.getProduct(event.categoryId);
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(allProduct: allProduct));
        } else {
          emit(
            ProductLoaded(
              games: const [],
              entertainment: const [],
              tagihan: const [],
              allProduct: allProduct,
            ),
          );
        }
      } catch (e) {
        emit(ProductError());
      }
    });

    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productRepo.addProduct(
          event.productId,
          event.name,
          event.categoryId,
          event.image,
        );
        emit(AddProductSuccess());
        add(GetProductByCategoryId(categoryId: event.categoryId));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<EditProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productRepo.editProduct(
          event.productId,
          event.name,
          event.categoryId,
          event.image,
        );
        emit(EditProductSuccess());
        add(GetProductByCategoryId(categoryId: event.categoryId));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productRepo.deleteProduct(event.productId);
        emit(DeleteProductSuccess());
        add(GetProductByCategoryId(categoryId: event.categoryId));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
