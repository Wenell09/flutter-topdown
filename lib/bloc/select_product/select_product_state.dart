part of 'select_product_bloc.dart';

class SelectProductState extends Equatable {
  final int index;
  // ignore: prefer_const_constructors_in_immutables
  SelectProductState({required this.index});

  @override
  List<Object> get props => [index];
}
