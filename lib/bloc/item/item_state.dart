part of 'item_bloc.dart';

sealed class ItemState extends Equatable {}

final class ItemInitial extends ItemState {
  @override
  List<Object?> get props => [];
}

final class ItemLoading extends ItemState {
  @override
  List<Object?> get props => [];
}

final class ItemLoaded extends ItemState {
  final List<ItemModel> item;
  ItemLoaded({required this.item});
  @override
  List<Object?> get props => [item];
}

final class ItemError extends ItemState {
  @override
  List<Object?> get props => [];
}
