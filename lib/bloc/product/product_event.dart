part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {}

class GetProductByCategoryId extends ProductEvent {
  final String categoryId;
  GetProductByCategoryId({required this.categoryId});
  @override
  List<Object?> get props => [categoryId];
}

class GetProductGames extends ProductEvent {
  final String categoryId;
  GetProductGames({required this.categoryId});
  @override
  List<Object?> get props => [categoryId];
}

class GetProductEntertainment extends ProductEvent {
  final String categoryId;
  GetProductEntertainment({required this.categoryId});
  @override
  List<Object?> get props => [categoryId];
}

class GetProductTagihan extends ProductEvent {
  final String categoryId;
  GetProductTagihan({required this.categoryId});
  @override
  List<Object?> get props => [categoryId];
}

class AddProduct extends ProductEvent {
  final String productId, name, categoryId, image;
  AddProduct({
    required this.productId,
    required this.name,
    required this.categoryId,
    required this.image,
  });
  @override
  List<Object?> get props => [productId, name, categoryId, image];
}

class EditProduct extends ProductEvent {
  final String productId, name, categoryId, image;
  EditProduct({
    required this.productId,
    required this.name,
    required this.categoryId,
    required this.image,
  });
  @override
  List<Object?> get props => [productId, name, categoryId, image];
}

class DeleteProduct extends ProductEvent {
  final String productId, categoryId;
  DeleteProduct({
    required this.productId,
    required this.categoryId,
  });
  @override
  List<Object?> get props => [productId, categoryId];
}
