part of 'select_item_bloc.dart';

class SelectItemState extends Equatable {
  final String itemId, itemName;
  final int itemPrice;
  // ignore: prefer_const_constructors_in_immutables
  SelectItemState(
      {required this.itemId, required this.itemName, required this.itemPrice});
  @override
  List<Object> get props => [itemId, itemName, itemPrice];
}
