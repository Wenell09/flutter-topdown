part of 'select_product_bloc.dart';

sealed class SelectProductEvent extends Equatable {}

class SelectProduct extends SelectProductEvent {
  final int index;
  SelectProduct({required this.index});
  @override
  List<Object?> get props => [index];
}
