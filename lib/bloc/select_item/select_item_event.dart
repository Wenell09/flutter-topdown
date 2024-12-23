part of 'select_item_bloc.dart';

sealed class SelectItemEvent extends Equatable {}

class AddSelectItem extends SelectItemEvent {
  final String itemId, itemName;
  final int itemPrice;
  AddSelectItem(
      {required this.itemId, required this.itemName, required this.itemPrice});
  @override
  List<Object?> get props => [itemId, itemName, itemPrice];
}
