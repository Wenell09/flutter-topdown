part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {}

class GetItem extends ItemEvent {
  final String productId;
  GetItem({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class AddItem extends ItemEvent {
  final String name, productId, image;
  final int price;
  AddItem({
    required this.name,
    required this.productId,
    required this.price,
    required this.image,
  });
  @override
  List<Object?> get props => [name, productId, price, image];
}

class EditItem extends ItemEvent {
  final String itemId, name, productId, image;
  final int price;
  EditItem({
    required this.itemId,
    required this.name,
    required this.productId,
    required this.price,
    required this.image,
  });
  @override
  List<Object?> get props => [itemId, name, productId, price, image];
}

class DeleteItem extends ItemEvent {
  final String itemId, productId;
  DeleteItem({
    required this.itemId,
    required this.productId,
  });
  @override
  List<Object?> get props => [itemId, productId];
}
