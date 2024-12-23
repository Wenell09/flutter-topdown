part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {}

class SearchProduct extends SearchProductEvent {
  final String name;
  SearchProduct({required this.name});
  @override
  List<Object?> get props => [name];
}
