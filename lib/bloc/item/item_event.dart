part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {}

class GetItem extends ItemEvent {
  final String productId;
  GetItem({required this.productId});
  @override
  List<Object?> get props => [productId];
}
