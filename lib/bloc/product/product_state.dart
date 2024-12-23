part of 'product_bloc.dart';

sealed class ProductState extends Equatable {}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> games;
  final List<ProductModel> entertainment;
  final List<ProductModel> tagihan;
  final List<ProductModel> allProduct;

  ProductLoaded({
    required this.games,
    required this.entertainment,
    required this.tagihan,
    required this.allProduct,
  });

  ProductLoaded copyWith({
    List<ProductModel>? games,
    List<ProductModel>? entertainment,
    List<ProductModel>? tagihan,
    List<ProductModel>? allProduct,
  }) {
    return ProductLoaded(
      games: games ?? this.games,
      entertainment: entertainment ?? this.entertainment,
      tagihan: tagihan ?? this.tagihan,
      allProduct: allProduct ?? this.allProduct,
    );
  }

  @override
  List<Object?> get props => [games, entertainment, tagihan];
}

final class AddProductSuccess extends ProductState {
  @override
  List<Object?> get props => [];
}

final class EditProductSuccess extends ProductState {
  @override
  List<Object?> get props => [];
}

final class DeleteProductSuccess extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductError extends ProductState {
  @override
  List<Object?> get props => [];
}
