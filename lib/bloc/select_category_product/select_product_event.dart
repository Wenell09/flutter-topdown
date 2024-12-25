part of 'select_product_bloc.dart';

sealed class SelectCategoryProductEvent extends Equatable {}

class SelectCategoryProduct extends SelectCategoryProductEvent {
  final int index;
  SelectCategoryProduct({required this.index});
  @override
  List<Object?> get props => [index];
}
