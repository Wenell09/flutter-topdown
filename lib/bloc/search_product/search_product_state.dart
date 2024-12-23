part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {}

final class SearchProductInitial extends SearchProductState {
  @override
  List<Object?> get props => [];
}

final class SearchProductLoading extends SearchProductState {
  @override
  List<Object?> get props => [];
}

final class SearchProductLoaded extends SearchProductState {
  final List<ProductModel> product;
  SearchProductLoaded({required this.product});
  @override
  List<Object?> get props => [product];
}

final class SearchProductError extends SearchProductState {
  @override
  List<Object?> get props => [];
}
